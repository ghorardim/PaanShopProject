public with sharing class PaanShopConostant {
    public static List<String> rawMaterialList = new List<String> {'Betel Nut (Supari)','BetelLeaf (Paan Pata)',
    'Flavor (Paan Mosla)', 'Fruit', 'Lime (Chun)'};
    public static List<String> paanObjFieldApi = new List<String> {'Betel_Nut__c','BetelLeaf__c','Flavor__c',
    'Fruit__c','Lime_Chun__c'};
    public static List<String> BuyerTableHeader = new List<String> {'Name','Phone Namber','Advance Payment', 'Be-Left Money' , 'Get Money'};
    public static final String Buyer_Table_Name = 'Buyer Table';
    public static final String Seller_Table_Name = 'Seller Table';
    public static final String Transaction_Table_Name = 'Tranaction Table';
    public static final String Paan_Table_Name = 'Paan Table';
    public static final String RawMaterial_Table_Name = 'Raw Material Table';
    public static List<String> TransactionTableHeader = new List<String> {'Party to transaction','Product name','Type','Pay cash','Advance Payment','Be-Left Money','Party get money','Quantity'};
    public static List<String> PaanTableHeader = new List<String> {'Paan Name','Price'};
    public static List<String> RawMaterialTableHeader = new List<String> {'Raw Material Name','Quantity'};
}
