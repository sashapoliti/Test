({
    searchContactsHelper : function(component, event) {
        console.log('ciao2');
        
        let action = component.get("c.getContacts");
        action.setParams({
            "searchTerm" : component.get("v.searchText")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                /* riempio la tabella con i contatti */
                component.set("v.contactsList", response.getReturnValue());

                /* resetto l'attribute */
                /* component.set("v.searchText", ""); */

                console.log(component.get("v.contactsList"));
                
            } else if(state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    }
})