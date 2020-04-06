({
    handleCreateRecordEvent : function(component, event, helper) {
        alert('REceived');
        console.log('event Received.......');
        var objectAndField = event.getParam('objectAndField');
        console.log('CreateRecordCmp ->: ',objectAndField);
        component.set('v.objApiName',objectAndField[0]);
        var i, length;
        length = objectAndField.length;
        var fields = [];
        for(i = 1; i < length ; i++){
            fields[i-1]=objectAndField[i];
        }
        component.set('v.fields',fields);
    }
})
