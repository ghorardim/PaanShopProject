({
    showPaanTypeList : function(component, event, helper) {
        var actionPaanType = component.get("c.getPaanTypeList");
        actionPaanType.setParams({
            
        });
        actionPaanType.setCallback(this, function (response) {
            var responseValue = response.getReturnValue();
            console.log("responseValue", responseValue);
            component.set('v.paanTypeList', responseValue);
            component.set('v.selectProductID',responseValue[0].Id);
            component.set('v.selectPaanPrice',responseValue[0].Price__c);
        });
        $A.enqueueAction(actionPaanType, false);
    },
    doSearchContact : function(component, event, helper){
        var phoneNumber = component.get('v.Phone');
        var contactDetails;
        var actionContactStatus = component.get("c.checkContactStatus");
        actionContactStatus.setParams({
            Phone : phoneNumber
        });
        actionContactStatus.setCallback(this, function (response) {
            contactDetails  = response.getReturnValue();
            console.log("Contact Status: ", contactDetails);
            helper.findContactStatus(component,contactDetails);
        });
        $A.enqueueAction(actionContactStatus, false);
    },
    makeNewContact : function(component, event, helper) {
        var Name, Phone, contactType, BeLeftMoney, AndavceMoney,ContactGetMoney;
        Name = component.get('v.ContactName');
        Phone = component.get('v.Phone');
        contactType = component.get('v.contactType');
        BeLeftMoney = '0';
        AndavceMoney = '0';
        ContactGetMoney = '0';
        var actionMakeNewContact = component.get("c.createNewContact");
        actionMakeNewContact.setParams({
            Name  : Name,
            Phone : Phone,
            contactType : contactType,
            BeLeftMoney : BeLeftMoney,
            AndavceMoney : AndavceMoney,
            ContactGetMoney : ContactGetMoney
        });
        actionMakeNewContact.setCallback(this, function (response) {
            console.log('NewContact: ',response.getReturnValue());
            component.set('v.contactObj',response.getReturnValue());
        });
        $A.enqueueAction(actionMakeNewContact, false);

    },
    sellPaan : function(component, event, helper){
        helper.doTransaction(component)
    },
    onSelectItem :  function(component, event, helper) {
        var productID  = component.find('paanTypeID').get('v.value');
        console.log(productID);
        component.set('v.selectProductID',productID);
        var paanTypeList = component.get('v.paanTypeList');
        for(var i = 0; i< paanTypeList.length; i++){
            if(productID == paanTypeList[i].Id){
                component.set('v.selectPaanPrice',paanTypeList[i].Price__c);
                break;
            }
        }
        
    }
})
