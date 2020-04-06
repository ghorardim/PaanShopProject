public with sharing class MaintainProductQuantity {
    public static String addRawMaterialQuantity(Decimal quantity, String productName){
        String msgReturn = 'Error';
        PaanShopRawMaterial__c rawMaterial = new PaanShopRawMaterial__c();
        try {
            rawMaterial = [SELECT Raw_Material_Name__c, Quantity__c FROM PaanShopRawMaterial__c Where Raw_Material_Name__c =: productName];
        } catch (Exception ex) {
            rawMaterial = null;
        }

        if(rawMaterial == null){
            rawMaterial.Quantity__c = quantity;
            rawMaterial.Raw_Material_Name__c = productName;
            insert rawMaterial;
            msgReturn = 'OK';
        }else {
            rawMaterial.Quantity__c = rawMaterial.Quantity__c + quantity;
            msgReturn = 'OK';
            update rawMaterial;
        }
        return msgReturn;
    }

    public static String reduceRawMaterialQuantity(Decimal quantity, String productName){
        System.debug('reduceRawMaterialQuantity: '+quantity + '-> ' + productName);
        String msgReturn = 'Error';
        PaanShopRawMaterial__c rawMaterial = new PaanShopRawMaterial__c();
        try {
            rawMaterial = [SELECT Raw_Material_Name__c, Quantity__c FROM PaanShopRawMaterial__c Where Raw_Material_Name__c =: productName];
        } catch (Exception ex) {
            rawMaterial = null;
        }

        if(rawMaterial == null){
            msgReturn = productName + ' not found in store';
        }else {
            if(rawMaterial.Quantity__c < quantity){
                msgReturn = productName + ' less unit stock';
            }else{
                rawMaterial.Quantity__c = rawMaterial.Quantity__c - quantity;
                update rawMaterial;
                msgReturn = 'OK';
            }
        }
        return msgReturn;
    }

    public static String paanSellReduceRawMaterialQuanttity(Decimal quantity, String paanID){
        System.debug(quantity + '-> ' + paanID);
        String msgReturn = 'Error';
        PaanShopPaanObject__c paanObj = new PaanShopPaanObject__c();
        paanObj = [SELECT Id, Name__c, Price__c, BetelLeaf__c, Betel_Nut__c, Lime_Chun__c, Flavor__c, Fruit__c 
           FROM PaanShopPaanObject__c Where Id =: paanID
          ];

          System.debug('Get Pann:  '+ '-> ' + paanObj);
        List<String> paanObjFieldApiList = new List<String>();
        paanObjFieldApiList = PaanShopConostant.paanObjFieldApi;

        List<String> rawMaterialList = new List<String>();
        rawMaterialList = PaanShopConostant.rawMaterialList;

        Integer length = rawMaterialList.size();

        for(Integer i = 0; i < length ; i++ ){
            String selectedFieldApi = paanObjFieldApiList.get(i);
            String selectedFieldName = rawMaterialList.get(i);
            Decimal num;
            if(selectedFieldName != 'Fruit'){
                num = (Decimal) paanObj.get(selectedFieldApi);
            }
            System.debug(selectedFieldName+ '->' + num);
            if(selectedFieldName == 'Fruit' && paanObj.get(selectedFieldApi) != null){
                msgReturn = reduceRawMaterialQuantity( quantity ,selectedFieldName);
            }else if(num != 0 && num != null){
                msgReturn = reduceRawMaterialQuantity( quantity * num,selectedFieldName);
            }else{
                msgReturn = 'OK';
            }
            if(msgReturn != 'OK'){
                break;
            }
        }

        System.debug('paanSellReduceRawMaterialQuanttity');


        return msgReturn;

    }
}
