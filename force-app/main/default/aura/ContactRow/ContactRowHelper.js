({
    deleteContactHelper : function(component, event) {
        console.log(event.getSource().get("v.value"));
        console.log(component.get("v.searchText"));
        
        let action = component.get("c.deleteContacts");
        action.setParams({
            "contactId" : event.getSource().get("v.value"),
            "search" : component.get("v.searchText")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                console.log('Contatto eliminato con successo');
                
                /* riempio la tabella con i contatti */
                component.set("v.contactsList", response.getReturnValue());
            } else if(state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    }
})