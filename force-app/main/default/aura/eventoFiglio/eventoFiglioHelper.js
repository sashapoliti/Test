({
    eventoAddHelper : function(component, event) {
        /* recupero l'evento */
        let ev = component.getEvent("myEvent");
        /* recupero attrobuti */
        let name = component.get("v.name");
        let phone = component.get("v.phone");
        
        /* faccio action */
        let action = component.get("c.addAccount");
        action.setParams({
            "name" : name,
            "phone" : phone
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                /* se aggiunto con successo, lancio evento
                con l'account aggiunto che mi ritorna e sparo evento */
                ev.setParams({
                    "newAccount" : response.getReturnValue()
                })
                ev.fire();
                /* nel dubbio, reset di attributi */
                component.set("v.name", "");
                component.set("v.phone", "");
            } else if(state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    }
})