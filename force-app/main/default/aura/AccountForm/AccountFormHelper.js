({
    callAddHelper : function(component, event) {
        /* recupero gli attribute del component */
        let name = component.get("v.name");
        let phone = component.get("v.phone");

        /* richiamo il metodo add del figlio */
        let figlio = component.find("CrudFiglio");
        figlio.add(name, phone);
    }
})