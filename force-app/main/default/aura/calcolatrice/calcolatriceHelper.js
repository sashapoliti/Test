({
  /* funzione per resettare tutto */
  svuotaTuttoHelper: function(component, event) {
    component.set("v.displayV", "");
    component.set("v.num1", "");
    component.set("v.num2", "");
    component.set("v.operazione", "");
    component.set("v.risultato", "false");
  },

  scriviHelper: function(component, event, currentValue, value) {
    component.set("v.displayV", currentValue + value);
  },

  scegliOperatoreHelper: function(component, event, currentValue) {
    component.set("v.num1", currentValue);
    component.set("v.displayV", "");
    component.set("v.operazione", event.getSource().get("v.label"));
  },

  calcolaHelper: function(component, event, num1, num2, operazione) {
    if (operazione === "+") {
      component.set("v.displayV", parseFloat(num1) + parseFloat(num2));
    } else if (operazione === "-") {
      component.set("v.displayV", parseFloat(num1) - parseFloat(num2));
    } else if (operazione === "x") {
      component.set("v.displayV", parseFloat(num1) * parseFloat(num2));
    } else if (operazione === "/") {
      if (num2 === 0) {
        component.set("v.displayV", "Errore");
        component.set("v.risultato", "true");
        return;
      }
      component.set("v.displayV", parseFloat(num1) / parseFloat(num2));
    }
    component.set("v.risultato", "true");
  },

  cancellaHelper: function(component, event) {
    if (component.get("v.risultato") === "true") {
      this.svuotaTuttoHelper(component, event);
    }
    let display = component.get("v.displayV");
    component.set("v.displayV", display.substring(0, display.length - 1));
  }
});