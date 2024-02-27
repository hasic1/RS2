import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/ocjena.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/models/vrste_proizvoda.dart';
import 'package:jamfix_admin/providers/ocjene_provider.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/providers/vrste_proizvoda_provider.dart';
import 'package:jamfix_admin/screens/plati_uslugu_screen.dart';
import 'package:jamfix_admin/screens/product_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  Product? product;
  VrsteProizvoda? vrsteProizvoda;
  ProductDetailScreen({this.product, this.vrsteProizvoda, Key? key})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final TextEditingController nazivProizvodaController =
      TextEditingController();
  final TextEditingController cijenaController = TextEditingController();
  final TextEditingController opisController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController brzinaInternetaController =
      TextEditingController();
  final TextEditingController brojKanalaController = TextEditingController();
  final TextEditingController brojMinutaPotvrdaController =
      TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  final _formKey1 = GlobalKey<FormState>();
  Map<String, dynamic> _initialValue = {};

  VrsteProizvodaProvider _vrsteProizvodaProvider = VrsteProizvodaProvider();
  ProductProvider _productProvider = ProductProvider();
  OcjeneProvider _ocjeneProvider=OcjeneProvider();
  
  bool userRole = true;
  SearchResult<VrsteProizvoda>? vrsteProizvodaResult;
  SearchResult<Product>? preporuceniProizvodi;
  String? selectedVrstaProizvodaId;

  double _rating = 1;
  bool isLoading = true;
  bool snizen = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'cijena': widget.product?.cijena.toString(),
      'nazivProizvoda': widget.product?.nazivProizvoda,
      'opis': widget.product?.opis,
      'snizen': widget.product?.snizen.toString(),
      'vrstaId': widget.product?.vrstaId?.toString(),
      'brzinaInterneta': widget.product?.brzinaInterneta,
      'brojMinuta': widget.product?.brojMinuta,
      'brojKanala': widget.product?.brojKanala,
    };
    cijenaController.text = _initialValue['cijena'] ?? '';
    nazivProizvodaController.text = _initialValue['nazivProizvoda'] ?? '';
    opisController.text = _initialValue['opis'] ?? '';
    emailController.text = _initialValue['cijena'] ?? '';
    brzinaInternetaController.text = _initialValue['brzinaInterneta'] ?? '';
    brojKanalaController.text = _initialValue['brojKanala'] ?? '';
    brojMinutaPotvrdaController.text = _initialValue['brojMinuta'] ?? '';

    _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();
    _productProvider = context.read<ProductProvider>();
    _ucitajPodatke();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _ucitajPodatke() async {
    var vrste = await _vrsteProizvodaProvider.get();

    if (widget.product != null && widget.product!.proizvodId != null) {
      var recommend = await _productProvider
          .fetchRecommendedProducts(widget.product!.proizvodId!);
      if (recommend != null) {
        setState(() {
          vrsteProizvodaResult = vrste;
          preporuceniProizvodi = recommend;
          isLoading = false;
        });
      } else {
        print("Error fetching recommended products.");
      }
    } else {
      setState(() {
        vrsteProizvodaResult = vrste;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Prosjecna ocjena: ${widget.product?.prosjecnaOcjena}",
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Slider(
                  value: _rating,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: _rating.toString(),
                  onChanged: (newValue) {
                    setState(() {
                      _rating = newValue;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    var request= Ocjene(
                      proizvodId: widget.product!.proizvodId,
                      ocjena: _rating.round(),
                      datum: DateTime.now(),
                    );
                    _ocjeneProvider.insert(request);
                  },
                  child: Text('Ocijeni'),
                ),
                newMethod(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column newMethod(BuildContext context) {
    return Column(
      children: [
        isLoading ? Container() : _buildForm(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: Authorization.isAdmin,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey1.currentState!.validate()) {
                      Product request = Product(
                        nazivProizvoda: nazivProizvodaController.text,
                        cijena: double.parse(cijenaController.text),
                        opis: opisController.text,
                        slika: _base65Image ?? '',
                        snizen: snizen,
                        brzinaInterneta: brzinaInternetaController.text,
                        brojMinuta: brojMinutaPotvrdaController.text,
                        brojKanala: brojKanalaController.text,
                        vrstaId: int.parse(selectedVrstaProizvodaId ??
                            _initialValue['vrstaId'].toString()),
                      );
                      Navigator.of(context).pop();
                      if (widget.product == null) {
                        await _productProvider.insert(request);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ProductListScreen(),
                          ),
                        );
                      } else {
                        await _productProvider.update(
                            widget.product!.proizvodId!, request);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ProductListScreen(),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Sacuvaj"),
                ),
              ),
            ),
            Visibility(
              visible: Authorization.isKorisnik,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PlatiUsluguScreen(product: widget.product),
                        ),
                      );
                    },
                    child: const Text("Dodaj narudzbu"),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Text(
          'Preporučeni proizvodi',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 15.0,
          runSpacing: 15.0,
          children: preporuceniProizvodi?.result.map((recommendedProduct) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: recommendedProduct,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.memory(
                          base64Decode(recommendedProduct.slika ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Form(
        key: _formKey1,
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Cijena"),
                  enabled: userRole == Authorization.isAdmin,
                  controller: cijenaController,
                  validator: (name) =>
                      name!.isEmpty ? 'Ime mora imati bar 3 slova' : null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Naziv"),
                  enabled: userRole == Authorization.isAdmin,
                  controller: nazivProizvodaController,
                  validator: (name) =>
                      name!.isEmpty ? 'Ime mora imati bar 3 slova' : null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Opis"),
                  enabled: userRole == Authorization.isAdmin,
                  controller: opisController,
                  validator: (name) =>
                      name!.isEmpty ? 'Ime mora imati bar 3 slova' : null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration:
                      const InputDecoration(labelText: "Brzina interneta"),
                  enabled: userRole == Authorization.isAdmin,
                  controller: brzinaInternetaController,
                  validator: (name) =>
                      name!.isEmpty ? 'Ime mora imati bar 3 slova' : null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Broj minuta"),
                  enabled: userRole == Authorization.isAdmin,
                  controller: brojMinutaPotvrdaController,
                  validator: (name) =>
                      name!.isEmpty ? 'Ime mora imati bar 3 slova' : null,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Broj kanala"),
                  enabled: userRole == Authorization.isAdmin,
                  controller: brojKanalaController,
                  validator: (name) =>
                      name!.length < 3 ? 'Ime mora imati bar 3 slova' : null,
                ),
              ),
            ],
          ),
          Visibility(
            visible: Authorization.isAdmin || Authorization.isZaposlenik,
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderDropdown<String>(
                    name: 'vrstaId',
                    decoration: InputDecoration(
                      labelText: 'Vrsta proizvoda',
                      suffix: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          selectedVrstaProizvodaId =
                              _initialValue['vrstaId']?.toString();
                        },
                      ),
                      hintText: 'Odaberi vrstu',
                    ),
                    enabled: userRole == Authorization.isAdmin,
                    items: vrsteProizvodaResult?.result
                            .map((item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: item.vrstaId.toString(),
                                  child: Text(item.naziv ?? ""),
                                ))
                            .toList() ??
                        [],
                    onChanged: (value) {
                      setState(() {
                        selectedVrstaProizvodaId = value;
                      });
                    },
                    initialValue: _initialValue['vrstaId'],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: Authorization.isAdmin,
            child: Row(
              children: [
                Expanded(
                    child: FormBuilderField(
                  name: 'imageId',
                  builder: ((field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          label: const Text('Odaberite sliku'),
                          errorText: field.errorText),
                      child: ListTile(
                        enabled: userRole == Authorization.isAdmin,
                        leading: const Icon(Icons.photo),
                        title: const Text("Select image"),
                        trailing: const Icon(Icons.file_upload),
                        onTap: getImage,
                      ),
                    );
                  }),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: Authorization.isAdmin,
            child: Row(
              children: [
                Checkbox(
                  value: snizen,
                  onChanged: (value) {
                    setState(() {
                      snizen = value!;
                    });
                  },
                ),
                const Text('Snizen'),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  File? _image;
  String? _base65Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base65Image = base64Encode(_image!.readAsBytesSync());
    }
  }
}
