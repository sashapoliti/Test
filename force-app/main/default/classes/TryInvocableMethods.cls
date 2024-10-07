public with sharing class TryInvocableMethods {

    /* creo una inner class */
    public class Input {
        /* annotazione per poter evocare la variabile */
        @InvocableVariable
        public String nome;
        @InvocableVariable
        public String nonserve;
    }

    @InvocableMethod /* annotazione per segnalare metodo invocabile */

    /* deve essere public (o global al massimo) e static obbligatoriamente, accetta in input stringhe di veriabili primitive, oggetti
    o classi personalizzate*/
    public static List<Account> GetAccountViaApex (List<Input> Inputs) {
        
        List<Account> accts = [SELECT Id, Name FROM Account WHERE Id = :inputs[0].nome LIMIT 1];

        return accts;
    }
}