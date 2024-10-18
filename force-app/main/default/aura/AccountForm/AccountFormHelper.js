({
    callAddHelper : function(component, event) {
        /* recupero gli attribute del component */
        let name = component.get("v.name");
        let phone = component.get("v.phone");

        /* richiamo il metodo add del figlio */
        let figlio = component.find("CrudFiglio");
        figlio.add(name, phone);

        /* resetto gli attribute */
        component.set("v.name", "");
        component.set("v.phone", "");
    },

    callDeleteHelper : function(component, event) {
        /* recupero gli attribute del component */
        let id = component.get("v.id");

        /* richiamo il metodo delete del figlio */
        let figlio = component.find("CrudFiglio");
        figlio.delete(id);

        /* resetto gli attribute */
        component.set("v.id", "");
    }
})