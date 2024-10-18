({
    deleteContactHelper : function(component, event) {
        component.set("v.contactId", event.target.value);
        component.set("v.showModal", true);
    }
})