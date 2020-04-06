public with sharing class PaanShopApexControllerObjectList {
    static final String EMPTY_TABLE = 'Sorry!!NO Record Found...';
    @AuraEnabled
    public static List<List<String>> getDataList(String objectName,String objType){
       List< List<String> >  returnTableData = new List< List<String> >();
       if(objectName == 'PaanShopContact__c'){
        returnTableData = getContactList(objType);
       }else if(objectName == 'PaanShopTransaction__c'){
        returnTableData = getTransactionList();
       }else if(objectName == 'PaanShopPaanObject__c'){
        returnTableData = getPaanList();
       }else if(objectName == 'PaanShopRawMaterial__c'){
        returnTableData = getRawMaterialList();
       }else{
        List< String > tableTitle = new  List< String >();
        tableTitle.add(objectName);
        returnTableData.add(tableTitle);
        List< String > tableBody = new  List< String >();
        tableBody.add(EMPTY_TABLE);
        returnTableData.add(tableBody);
       }

       return returnTableData;
    }

    private static List< List<String> > getContactList(String objType){
        List< List<String> > recordTableData = new  List< List<String> >();
        List< String > tableTitle = new  List< String >();

        String notType = '';
        if(objType == 'Buyer'){
            notType = 'Seller';
            tableTitle.add(PaanShopConostant.Buyer_Table_Name);
        }else {
            notType = 'Buyer';
            tableTitle.add(PaanShopConostant.Seller_Table_Name);
        }

        recordTableData.add(tableTitle);

        List< String > tableHead = new  List< String >();
        tableHead = PaanShopConostant.BuyerTableHeader;
        recordTableData.add(tableHead);

        

        List<PaanShopContact__c> contactList = new List<PaanShopContact__c>(
            [SELECT Id, Name, PhoneNumber__c, Type__c, AdvancePayment__c, BeLelfPayment__c, Contact_Get_Money__c 
            FROM PaanShopContact__c WHERE Type__c != :notType]
        );

        for( PaanShopContact__c contact : contactList){
            List< String > singleRowData = new  List< String >();
            singleRowData.add(contact.Id);
            singleRowData.add(contact.Name);
            singleRowData.add(contact.PhoneNumber__c);
            singleRowData.add(String.valueOf(contact.AdvancePayment__c));
            singleRowData.add(String.valueOf(contact.BeLelfPayment__c));
            singleRowData.add(String.valueOf(contact.Contact_Get_Money__c));
            
            recordTableData.add(singleRowData);
             
        }
       
        return recordTableData;
    }
    private static List< List<String> > getTransactionList(){
        List< List<String> > recordTableData = new  List< List<String> >();
        List< String > tableTitle = new  List< String >();

        tableTitle.add(PaanShopConostant.Transaction_Table_Name);

        recordTableData.add(tableTitle);

        List< String > tableHead = new  List< String >();
        tableHead = PaanShopConostant.TransactionTableHeader;
        recordTableData.add(tableHead);

        List<PaanShopTransaction__c> transactionList = new List<PaanShopTransaction__c>(
            [SELECT Id, Party_To_The_Transaction__c, PaanShopContactID__c, Transaction_Type__c, Product_Type__c, 
            Product_Name__c, ProductID__c, Quantity__c, Pay_Cash__c, AdvancePayment__c, Party_Get_Money__c, 
            BeLelfPayment__c, Remark__c FROM PaanShopTransaction__c]
        );

        for( PaanShopTransaction__c transactionObj : transactionList){
            List< String > singleRowData = new  List< String >();
            singleRowData.add(transactionObj.Id);
            singleRowData.add(transactionObj.Party_To_The_Transaction__c);
            singleRowData.add(transactionObj.Product_Name__c);
            singleRowData.add(transactionObj.Transaction_Type__c);
            singleRowData.add(String.valueOf(transactionObj.Pay_Cash__c));
            singleRowData.add(String.valueOf(transactionObj.AdvancePayment__c));
            singleRowData.add(String.valueOf(transactionObj.BeLelfPayment__c));
            singleRowData.add(String.valueOf(transactionObj.Party_Get_Money__c));
            singleRowData.add(String.valueOf(transactionObj.Quantity__c));
            
            recordTableData.add(singleRowData);
             
        }
       
        return recordTableData;
    }

    private static List< List<String> > getPaanList(){
        List< List<String> > recordTableData = new  List< List<String> >();
        List< String > tableTitle = new  List< String >();

        tableTitle.add(PaanShopConostant.Paan_Table_Name);

        recordTableData.add(tableTitle);

        List< String > tableHead = new  List< String >();
        tableHead = PaanShopConostant.PaanTableHeader;
        recordTableData.add(tableHead);

        List<PaanShopPaanObject__c> paanList = new List<PaanShopPaanObject__c>(
            [SELECT Id, BetelLeaf__c, Betel_Nut__c, Lime_Chun__c, Flavor__c, Fruit__c, Price__c, Name__c
             FROM PaanShopPaanObject__c]
        );

        for( PaanShopPaanObject__c paan : paanList){
            List< String > singleRowData = new  List< String >();
            singleRowData.add(paan.Id);
            singleRowData.add(paan.Name__c);
            singleRowData.add(String.valueOf(paan.Price__c));
            
            recordTableData.add(singleRowData);
             
        }
       
        return recordTableData;
    }

    private static List< List<String> > getRawMaterialList(){
        List< List<String> > recordTableData = new  List< List<String> >();
        List< String > tableTitle = new  List< String >();

        tableTitle.add(PaanShopConostant.RawMaterial_Table_Name);

        recordTableData.add(tableTitle);

        List< String > tableHead = new  List< String >();
        tableHead = PaanShopConostant.RawMaterialTableHeader;
        recordTableData.add(tableHead);

        List<PaanShopRawMaterial__c> rawMaterialList = new List<PaanShopRawMaterial__c>(
            [SELECT Id, Raw_Material_Name__c, Quantity__c FROM PaanShopRawMaterial__c]
        );

        for( PaanShopRawMaterial__c rawmaterial : rawMaterialList){
            List< String > singleRowData = new  List< String >();
            singleRowData.add(rawmaterial.Id);
            singleRowData.add(rawmaterial.Raw_Material_Name__c);
            singleRowData.add(String.valueOf(rawmaterial.Quantity__c));
            
            recordTableData.add(singleRowData);
             
        }
       
        return recordTableData;
    }
}
