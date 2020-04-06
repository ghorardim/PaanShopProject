trigger PaanShopTriggerAfterTransaction on PaanShopTransaction__c (after insert) {
    List<PaanShopTransaction__c> objList = new List<PaanShopTransaction__c>();
    Map<ID, PaanShopContact__c> mapContact = new Map<ID, PaanShopContact__c>(
        [SELECT Id, Name, PhoneNumber__c, Type__c, AdvancePayment__c, BeLelfPayment__c, Contact_Get_Money__c FROM PaanShopContact__c]);
        
    for(PaanShopTransaction__c obj : Trigger.new){
        PaanShopContact__c contactObj = new PaanShopContact__c();
        contactObj = mapContact.get(obj.PaanShopContactID__c);
        if((obj.Transaction_Type__c == 'Buy' && contactObj.Type__c == 'Buyer') ||
         (obj.Transaction_Type__c == 'Sell' && contactObj.Type__c == 'Seller')) {
            contactObj.Type__c = 'Buyer and Seller';
        }
        contactObj.AdvancePayment__c = contactObj.AdvancePayment__c + obj.AdvancePayment__c;
        contactObj.BeLelfPayment__c  = contactObj.BeLelfPayment__c + obj.BeLelfPayment__c;
        contactObj.Contact_Get_Money__c = contactObj.Contact_Get_Money__c + obj.Party_Get_Money__c;
        PaanShopApexController.updateContactByObject(contactObj);
    }
}