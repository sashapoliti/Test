({
    eventoFiglioHelper : function(component, event) {
        console.log('ciao');
        
        /* recupero l'evento */
        let contact = event.getParam("newAccount");
        console.log(contact);
        
        let accountList = component.get("v.listaAccount");

        accountList.push(contact);
        console.log(accountList);

        /* Setto il valore dell'event in attributo */        
        component.set("v.listaAccount", accountList);
        
        console.log("Lista aggiornata di account: ", component.get("v.listaAccount"));       
    }
})