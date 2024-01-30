using AutoMapper;
using JamFix.Model.Modeli;
using JamFix.Model.Requests;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.ProizvodiSM;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using JamFix.ML;

namespace JamFix.Services.Service
{
    public class ProizvodiService : BaseCRUDService<Proizvodi, Proizvod, ProizvodiSO, ProizvodiInsertRequest, ProizvodiUpdateRequest>, IProizvodiService
    {
        public BaseState _baseState { get; set; }
        protected IMapper _mapper { get; set; }
        protected Context _context;
        static MLContext mlContext = null;
        static ITransformer model = null;
        public ProizvodiService(BaseState baseState, Context context, IMapper mapper) : base(context, mapper)
        {
            _baseState = baseState;
            _mapper = mapper;
            _context = context;
        }

        public override IQueryable<Proizvod> AddFilter(IQueryable<Proizvod> query, ProizvodiSO? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.NazivProizvoda.Contains(search.FTS) || x.Cijena.ToString().Contains(search.FTS));
            }

            if (!string.IsNullOrWhiteSpace(search?.Cijena))
            {
                filteredQuery = filteredQuery.Where(x => x.Cijena.ToString() == search.Cijena.ToString());
            }

            return filteredQuery;
        }

        public override Task<Proizvodi> Insert(ProizvodiInsertRequest insert)
        {
            var state = _baseState.CreateState("initial");
            return state.Insert(insert);
        }

        public override async Task<Proizvodi> Update(int id, ProizvodiUpdateRequest update)
        {
            var entity = await _context.Proizvod.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Update(id, update);
        }

        public async Task<Proizvodi> Activate(int id)
        {
            var entity = await _context.Proizvod.FindAsync(id);
            var state = _baseState.CreateState(entity.StateMachine);
            return await state.Activate(id);
        }

        public async Task<Proizvodi> Hide(int id)
        {
            var product = _context.Proizvod.Find(id);
            var state = _baseState.CreateState(product.StateMachine);
            state.CurrentEntity = product;
            state.Hide();
            return await GetById(id);
        }

        public async Task<List<string>> AllowedActions(int id)
        {
            var entity = await _context.Proizvod.FindAsync(id);
            var state = _baseState.CreateState(entity?.StateMachine ?? "initial");
            return await state.AllowedActions();
        }

        public virtual async Task<PagedResult<Proizvodi>> GetTopRatedProducts( int numberOfTopProducts)
        {
            PagedResult<Proizvodi> result = new PagedResult<Proizvodi>();

            var proizvodi = await _context.Proizvod
                .Include(p => p.Ocjene)  
                .ToListAsync();

            var mappedProizvodi = _mapper.Map<List<Proizvodi>>(proizvodi);
            foreach (var proizvod in mappedProizvodi)
            {
                proizvod.ProsjecnaOcjena = proizvod.Ocjene.Count > 0 ? proizvod.Ocjene.Average(o => o.ocjena) : 0;
            }
            mappedProizvodi = mappedProizvodi.OrderByDescending(p => p.ProsjecnaOcjena).ToList();
            result.Result = mappedProizvodi.Take(numberOfTopProducts).ToList();

            return result;
        }
        public class RecommendationResponse<T>
        {
            public List<T> Result { get; set; }
            public int Count { get; set; }
        }
        public RecommendationResponse<Proizvodi> Recommend(int id)
        {
            if (mlContext == null)
            {

                mlContext = new MLContext();
                //STEP 2: Read the trained data using TextLoader by defining the schema for reading the product co-purchase dataset
                //        Do remember to replace amazon0302.txt with dataset from https://snap.stanford.edu/data/amazon0302.html
                //var traindata = mlContext.Data.LoadFromTextFile(path: TrainingDataLocation,
                //                                                  columns: new[]
                //                                                            {
                //                                                    new TextLoader.Column("Label", DataKind.Single, 0),
                //                                                    new TextLoader.Column(name:nameof(ProductEntry.ProductID), dataKind:DataKind.UInt32, source: new [] { new TextLoader.Range(0) }, keyCount: new KeyCount(262111)),
                //                                                    new TextLoader.Column(name:nameof(ProductEntry.CoPurchaseProductID), dataKind:DataKind.UInt32, source: new [] { new TextLoader.Range(1) }, keyCount: new KeyCount(262111))
                //                                                            },
                //                                                  hasHeader: true,
                //                                                  separatorChar: '\t');

                var tmpData = _context.Usluge.Include("UslugaStavke").ToList();
                var data = new List<ProductEntry>();
                foreach (var x in tmpData)
                {
                    if (x.UslugaStavke.Count > 1)
                    {
                        var distinctIdemId = x.UslugaStavke.Select(y => y.ProizvodId).ToList();
                        distinctIdemId.ForEach(y =>
                        {
                            var relatedItems = x.UslugaStavke.Where(z => z.ProizvodId != y).ToList();

                            relatedItems.ForEach(z => {
                                data.Add(new ProductEntry() { ProductID = (uint)y, CoPurchaseProductID = (uint)z.ProizvodId });
                            });
                        });
                    }
                }
                var traindata = mlContext.Data.LoadFromEnumerable(data);
                //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
                //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
                MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                options.LabelColumnName = "Label";
                options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                options.Alpha = 0.01;
                options.Lambda = 0.025;
                // For better results use the following parameters
                //options.K = 100;
                options.C = 0.00001;

                //Step 4: Call the MatrixFactorization trainer by passing options.
                var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);


                //STEP 5: Train the model fitting to the DataSet
                //Please add Amazon0302.txt dataset from https://snap.stanford.edu/data/amazon0302.html to Data folder if FileNotFoundException is thrown.
                model = est.Fit(traindata);
            }
            //STEP 6: Create prediction engine and predict the score for Product 63 being co-purchased with Product 3.
            //        The higher the score the higher the probability for this particular productID being co-purchased
            var allItems = _context.Proizvod.Where(x => x.ProizvodId != id).ToList();
            var predictionResult = new List<Tuple<Proizvod, float>>();

            foreach (var item in allItems)
            {
                var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                var prediction = predictionengine.Predict(
                                         new ProductEntry()
                                         {
                                             ProductID = (uint)id,
                                             CoPurchaseProductID = (uint)item.ProizvodId
                                         });
                predictionResult.Add(new Tuple<Proizvod, float>(item, prediction.Score));
            }
            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                                       .Select(x => x.Item1)
                                       .Take(3)
                                       .ToList();
            var response = new RecommendationResponse<Proizvodi>
            {
                Result = _mapper.Map<List<Proizvodi>>(finalResult),
                Count = finalResult.Count
            };

            return response;
        }
    }
}