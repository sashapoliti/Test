({
  /* scrivo i numeri */
  scriviSuDisplay: function(component, event, helper) {
    let risultato = component.get("v.risultato");
    if (risultato === "true") {
      helper.svuotaTuttoHelper(component, event);
    }

    /* prendo prima il valore del bottone
        poi il valore che è già nello schermo*/
    let value = event.getSource().get("v.label");
    let currentValue = component.get("v.displayV");

    /* li sommo per aggiungere numeri
        nell'helper perché è una roba di visualizzazione*/
    helper.scriviHelper(component, event, currentValue, value);
  },

    
  /* cancello l'ultimo numero inserito */
  cancella: function(component, event, helper) {
    helper.cancellaHelper(component, event);
  },

    
  /* cancello tutto */
  svuotaTutto: function(component, event, helper) {
    helper.svuotaTuttoHelper(component, event);
  },

  scegliOperatore: function(component, event, helper) {
    let currentValue = component.get("v.displayV");
    if (currentValue === "") {
      return;
    }

    helper.scegliOperatoreHelper(component, event, currentValue);
  },

  calcola: function(component, event, helper) {
    let num1 = parseFloat(component.get("v.num1"));
    let risultato = component.get("v.risultato");
    let operazione = component.get("v.operazione");
    let display = component.get("v.displayV");
    if (risultato === "true") {
      component.set("v.risultato", "false");
    }
    component.set("v.num2", display);
    let num2 = parseFloat(component.get("v.num2"));
    if (!num2 && num2 !== 0) {
      num2 = parseFloat(component.get("v.num1"));
    }

    helper.calcolaHelper(component, event, num1, num2, operazione);
  }
});