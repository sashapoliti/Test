({
    addHelper : function(component, event) {
        /* recupero gli attribute del component */
        let params = event.getParam("arguments");
        console.log(params);
        
        /* richiamo metodo della classe per aggiungere account */
        let action = component.get("c.addAccount");
        action.setParams({
            "name" : params.name,
            "phone" : params.phone
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                /* se aggiunto con successo, aggiungo messaggio */
                component.set("v.message", "Account aggiunto con successo");
                /* nel dubbio, reset di attributi */
                component.set("v.name", "");
                component.set("v.phone", "");
            } else if(state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    },

    deleteHelper : function(component, event) {
        /* recupero gli attribute del component */
        let params = event.getParam("arguments");
        console.log(params);

        /* richiamo metodo della classe per cancellare account */
        let action = component.get("c.deleteAccount");
        action.setParams({
            "id" : params.id
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === "SUCCESS") {
                /* se cancellato con successo, aggiungo messaggio */
                component.set("v.message", "Account cancellato con successo");
            } else if(state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    }
})