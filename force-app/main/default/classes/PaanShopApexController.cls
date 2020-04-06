public with sharing class PaanShopApexController {
    @AuraEnabled
    public static PaanShopContact__c createNewContact(String Name, String Phone, String contactType, String BeLeftMoney,
     String AndavceMoney,String ContactGetMoney){
        PaanShopContact__c objContact = new PaanShopContact__c();
        Decimal BeLeftMoneyD , AndavceMoneyD,ContactGetMoneyD;
        BeLeftMoneyD = decimal.valueOf(BeLeftMoney);
        AndavceMoneyD = decimal.valueOf(AndavceMoney);
        ContactGetMoneyD = Decimal.valueOf(ContactGetMoney);
        objContact.Name = Name;
        objContact.Type__c = contactType;
        objContact.PhoneNumber__c = Phone;
        objContact.BeLelfPayment__c = BeLeftMoneyD;
        objContact.AdvancePayment__c = AndavceMoneyD;
        objContact.Contact_Get_Money__c = ContactGetMoneyD;
        insert objContact;
        return objContact;
    }
    @AuraEnabled
    public static PaanShopContact__c checkContactStatus(String Phone){
        PaanShopContact__c objContact = new PaanShopContact__c();
        try {
            objContact = [SELECT Id, Name, PhoneNumber__c, Type__c, AdvancePayment__c, BeLelfPayment__c, Contact_Get_Money__c 
             FROM PaanShopContact__c Where PhoneNumber__c =: Phone];
        } catch (Exception ex) {
            objContact = null;
        }
        return objContact;
    }
    @AuraEnabled
    public static void updateContactStatus(String Name, String Phone, String contactType, String BeLeftMoney, 
    String AndavceMoney, String payment, String ID){
        PaanShopContact__c objContact = new PaanShopContact__c();
        objContact = [SELECT Id, Name, PhoneNumber__c, Type__c, AdvancePayment__c, BeLelfPayment__c FROM PaanShopContact__c 
            Where Id =: ID];
        Decimal BeLeftMoneyD , AndavceMoneyD,paymentD;
        BeLeftMoneyD = decimal.valueOf(BeLeftMoney);
        AndavceMoneyD = decimal.valueOf(AndavceMoney);
        paymentD = Decimal.valueOf(payment);
        if(Name!=null && !Name.equals('')){
            objContact.Name = Name;
        }
        if(Phone!=null && !Phone.equals('')){
            objContact.PhoneNumber__c = Phone;
        }
        if(contactType!=null && !contactType.equals(objContact.Type__c)){
            objContact.Type__c = 'Buyer and Seller';
        }
        objContact.BeLelfPayment__c += BeLeftMoneyD;
        objContact.AdvancePayment__c += AndavceMoneyD;

        if(BeLeftMoneyD>0){
            objContact.BeLelfPayment__c -= paymentD;
        }else {
            objContact.AdvancePayment__c += paymentD;
        }
        insert objContact;
    }
    @AuraEnabled
    public static void addPaanShopTransaction(String PartyName, String PartyID, String transactionType, String productType,
    String productName, String productID,String quantity, String payCash, String part_get_money,String BeLeftMoney,
    String AndavceMoney, String Remark){
        PaanShopTransaction__c objTransAction = new PaanShopTransaction__c();
        Decimal BeLeftMoneyD , AndavceMoneyD,payCashD, part_get_moneyD, quantityD;
        BeLeftMoneyD = Decimal.valueOf(BeLeftMoney);
        AndavceMoneyD = Decimal.valueOf(AndavceMoney);
        payCashD = Decimal.valueOf(payCash);
        part_get_moneyD = Decimal.valueOf(part_get_money);
        quantityD = Decimal.valueOf(quantity);
        objTransAction.Party_To_The_Transaction__c = PartyName;
        objTransAction.PaanShopContactID__c = PartyID;
        objTransAction.Transaction_Type__c = transactionType;
        objTransAction.Product_Type__c = productType;
        objTransAction.Product_Name__c = productName;
        objTransAction.ProductID__c = productID;
        objTransAction.Quantity__c  = quantityD;
        objTransAction.Pay_Cash__c = payCashD;
        objTransAction.Party_Get_Money__c = part_get_moneyD;
        objTransAction.BeLelfPayment__c = BeLeftMoneyD;
        objTransAction.AdvancePayment__c = AndavceMoneyD;
        objTransAction.Remark__c = Remark;
        System.debug('TransAction -> '+objTransAction);
        insert objTransAction;
    }
    @AuraEnabled
    public static List<PaanShopRawMaterial__c> getRawMaterialList(){
        List<PaanShopRawMaterial__c> rawMaterialList = new List<PaanShopRawMaterial__c>();
        rawMaterialList = [SELECT Id, Raw_Material_Name__c, Quantity__c FROM PaanShopRawMaterial__c];
        return rawMaterialList;
    }
    @AuraEnabled
    public static void updateContactByObject(PaanShopContact__c newObj){
        System.debug('UpdateContact -> '+newObj);
        if(newObj != null){
            update newObj;
        }
    }
    @AuraEnabled
    public static List<PaanShopPaanObject__c> getPaanTypeList(){
        List<PaanShopPaanObject__c> paanTypeList = new List<PaanShopPaanObject__c>();
        paanTypeList = [SELECT Id, Name__c, Price__c, BetelLeaf__c, Betel_Nut__c, Lime_Chun__c, Flavor__c, Fruit__c FROM PaanShopPaanObject__c];
        return paanTypeList;
    }
}
