({
    findContactStatus: function (component, contactDetails) {
        console.log('helper: '+ 'findContactStatus');
        component.set('v.contactObj', contactDetails);
        if (contactDetails != null) {
            component.set('v.ContactName', contactDetails.Name);
        } else {
            component.set('v.ContactName', '');
            component.find('contactID').set('v.placeholder', 'Input New Contact Name');
        }
    },
    doTransaction: function (component) {
        console.log('doTransaction -> helper');
        var PartyName, PartyID, transactionType, productType, productName;
        var productID, quantity, payCash, part_get_money, BeLeftMoney, AndavceMoney, Remark;
        var contactObj = component.get('v.contactObj');
        
        PartyName = contactObj.Name;
        PartyID = contactObj.Id;
        transactionType = component.get('v.transactionType');
        productType = component.get('v.productType');
        productID = component.get('v.selectProductID');
        productName = this.findSelectedProductName(component,productID);
        quantity = component.get('v.Quantity');
        payCash = component.get('v.PayCash');
        AndavceMoney = component.get('v.AdvancePayment');
        part_get_money = component.get('v.PartyGetMoney');
        BeLeftMoney = '0';
        Remark = component.get('v.Remark');

        console.log('CHECK->' + PartyName + '' + PartyID);
        console.log('CHECK->' + transactionType + '' + productType);
        console.log('CHECK->' + productID + '' + productName);
        console.log('CHECK->' + quantity + '' + payCash);
        console.log('CHECK->' + AndavceMoney + '' + part_get_money);
        console.log('CHECK->' + BeLeftMoney + '' + Remark);

        var actionTransaction = component.get('c.addPaanShopTransaction');
        actionTransaction.setParams({
            PartyName : PartyName, 
            PartyID : PartyID,
            transactionType : transactionType, 
            productType : productType, 
            productName : productName, 
            productID : productID, 
            quantity :  quantity, 
            payCash : payCash, 
            part_get_money : part_get_money, 
            BeLeftMoney : BeLeftMoney, 
            AndavceMoney : AndavceMoney, 
            Remark : Remark
        });
        actionTransaction.setCallback(this, function (response) {
            console.log(response.getState());
            alert('Transaction: '+response.getState());
            if(response.getState()=='SUCCESS'){
                document.location.reload();
            }
        });
        $A.enqueueAction(actionTransaction, false);

    },
    findSelectedProductName: function (component,productID) {
        console.log('findSelectedProductName  -> helper');
        var productList = component.get('v.rawMaterialList');
        var length = productList.length;
        var i, name;
        console.log('I m here........');
        for (i = 0; i < length; i++) {
            if(productList[i].Id == productID){
                name = productList[i].Raw_Material_Name__c;
                break;
            }
        }
        return name;
    }
})