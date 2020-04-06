trigger PaanShopTiggerCheckTransaction on PaanShopTransaction__c (before insert) {
    Boolean isOK = true;
    List<PaanShopTransaction__c> objList = new List<PaanShopTransaction__c>();
    for(PaanShopTransaction__c obj : Trigger.new){
        if(obj.Pay_Cash__c == null && obj.Party_Get_Money__c == null && obj.BeLelfPayment__c == null){
            isOK = false;
            obj.addError('Among Pay Cash, Party Get Money and Be Left Payment, at least one field value need to input data');
        }else if(String.isBlank(obj.ProductID__c) && String.isBlank(obj.Remark__c)){
            isOK = false;
            obj.addError('Please input transaction details in Remark');
        }else {
            objList.add(obj);
        }
    }

    System.debug('Before -> '+ isOK);

    if(isOK){
        String receiveMsg;
        for(PaanShopTransaction__c obj : objList){
            if(obj.Transaction_Type__c == 'Buy' && obj.Product_Type__c == 'PaanShopRawMaterial'){
                receiveMsg = MaintainProductQuantity.addRawMaterialQuantity(obj.Quantity__c, obj.Product_Name__c);
            }else if (obj.Transaction_Type__c == 'Sell' && obj.Product_Type__c == 'PaanShopRawMaterial'){
                receiveMsg = MaintainProductQuantity.reduceRawMaterialQuantity(obj.Quantity__c, obj.Product_Name__c);
            }else if(obj.Transaction_Type__c == 'Sell' && obj.Product_Type__c == 'PaanShopPaanObject'){
                receiveMsg = MaintainProductQuantity.paanSellReduceRawMaterialQuanttity(obj.Quantity__c, obj.ProductID__c);
            }

            if(!receiveMsg.endsWithIgnoreCase('OK')){
                obj.addError(receiveMsg);
            }
        }
    }

}
