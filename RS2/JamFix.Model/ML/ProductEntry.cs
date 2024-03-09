using Microsoft.ML.Data;

namespace JamFix.ML
{
    public class Copurchase_prediction
    {
        public float Score { get; set; }
    }

    public class ProductEntry
    {
        [KeyType(count: 2000)]
        public uint ProductID { get; set; }

        [KeyType(count: 2000)]
        public uint CoPurchaseProductID { get; set; }
        public float Label { get; set; }
    }
}
