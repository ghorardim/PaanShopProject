({
    showRawMaterialList : function(component, event, helper) {
        var actionRawMaterial = component.get("c.getRawMaterialList");
        actionRawMaterial.setParams({
            
        });
        actionRawMaterial.setCallback(this, function (response) {
            var responseValue = response.getReturnValue();
            console.log("responseValue", responseValue);
            component.set('v.rawMaterialList', responseValue);
            component.set('v.selectProductID',responseValue[0].Id);
        });
        $A.enqueueAction(actionRawMaterial, false);
    },
    changeItem : function(component, event, helper) {
        var productID  = component.find('select').get('v.value');
        console.log(productID);
        component.set('v.selectProductID',productID);
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
    buyRawMaterial : function(component, event, helper) {
        console.log('buyRawMaterial -> controller');
        helper.doTransaction(component)
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

    }
})
