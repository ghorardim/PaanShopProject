({
    sendObjectAndField: function (component, event, helper) {
        var objectAndField = component.get('v.objectAndField');
        console.log('Buyer List: ',objectAndField);
        var eventObjField = $A.get("e.c:PaanShopEventCreateRecord");
        eventObjField.setParams({

            "objectAndField" : objectAndField
        });
        eventObjField.fire();
        console.log('Event fair.....');
    }
})