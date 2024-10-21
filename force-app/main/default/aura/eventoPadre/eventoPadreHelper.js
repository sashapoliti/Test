({
    eventoFiglioHelper : function(component, event) {
        /* recupero l'evento */
        let contacts = event.getParam("newAccount");

        /* Setto il valore dell'event in attributo */
        console.log(contacts);
        component.set("v.nuovoAccount", contacts);
        
        console.log(component.get("v.nuovoAccount"));        
    }
})