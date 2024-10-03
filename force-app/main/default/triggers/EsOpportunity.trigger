/* Scrivi un trigger su **Opportunity** che, quando un'opportunità viene chiusa con esito positivo (valore del campo **StageName** uguale a "Closed Won"),
aggiorna il campo **Description** dell'account associato, inserendo una frase personalizzata che includa il nome dell'opportunità e l'importo.
Il messaggio deve essere del tipo: “L'opportunità {Opportunity.Name} è stata chiusa con successo con un importo di {Opportunity.Amount}".
Assicurati di gestire correttamente i casi di aggiornamento di più opportunità contemporaneamente. */

trigger EsOpportunity on Opportunity (after insert, after update) {
    /* creo una lista di Account da aggiornare */
    list <Account> accountUpdate = new list <Account> ();

    for (Opportunity o : Trigger.new) {
        /* Controllo se inserita come già chiusa oppure se modificata e prima non era già Closed Won */
        if ((o.StageName == 'Closed Won' && Trigger.isInsert) || (Trigger.isUpdate && Trigger.oldMap.get(o.Id).StageName != 'Closed Won')) {
            /* Controllo sia stata associata ad un account (non è required) */
            if (o.AccountId != null) {
               /* Creo l'account con l'id e la description */
               Account a = new Account(
                   Id = o.AccountId,
                   Description = 'L\'opportunità ' + o.Name + ' è stata chiusa con successo con un importo di ' + o.Amount + '€.'
               );
               accountUpdate.add(a);
            }
        }
    }

    /* Aggiorno gli account relativi alle opportunità */
    if (!accountUpdate.isEmpty()) {
        update accountUpdate;
    }
}