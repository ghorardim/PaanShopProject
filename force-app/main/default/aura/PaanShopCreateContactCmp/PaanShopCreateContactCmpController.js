({
    handleClick: function (component, event, helper) {
        component.set('v.isOpen', true);
    },
    closeModal: function (component, event, helper) {
        component.set('v.isOpen', false);
    },
    handleSuccess: function (component, event, helper) {
        component.set('v.isOpen', false);
        document.location.reload();
    },
    onCancel: function (component, event, helper) {
        component.set('v.isOpen', false);
    }
})