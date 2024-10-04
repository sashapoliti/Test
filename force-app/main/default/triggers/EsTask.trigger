/* Scrivi un trigger su **Task** che, quando un'attività con valore del campo **Status** uguale a "Completed" viene creata o aggiornata,
aggiorni il campo **LastActivityDate** dell'account associato all'attività con la data di completamento dell'attività stessa.
Assicurati di gestire correttamente i casi in cui ci siano più attività completate contemporaneamente per lo stesso account. */

trigger EsTask on Task (after insert, after update) {

    /* Creo una lista di Account da aggiornare */
    List <Account> accountUpdate = new List <Account> ();

    for (Task t : Trigger.New) {
        /* Controllo che il task sia Completed (non serve account associato perché è required) */
        if (t.Status == 'Completed') {
            /* Creo l'account */
            Account a = new Account(
                Id = t.AccountId,
                UltimaAttivitaCompletata__c = t.CompletedDateTime /* creato campo custom dato che LastActivityDate è solo lettura  */
            );
            accountUpdate.add(a);            
        }        
    }

    /* Non controllo la query se sia vuota perché account è required
    quindi faccio direttamente update */
    update accountUpdate;
}