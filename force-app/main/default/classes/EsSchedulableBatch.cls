global with sharing class EsSchedulableBatch implements Database.Batchable<sObject> {
    
    /* metodo start sui contact, con query per i cases con picklist status != 'Closed' */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Status, Description, Subject FROM Case WHERE Status != \'Closed\'');
    }

    /* metodo execute */
    global void execute(Database.BatchableContext BC, List<Case> scope) {
        /* la lista dei case da fare update o da aggiungere per reclami*/
        List<Case> updateCase = new List<Case> ();
        List<Case> insertCaseReclami = new List<Case> ();

        for (Case c : scope) {
            /* se il case è nuovo, spostarlo nello stato successivo */
            if (c.Status == 'New') {
                c.Status = 'Working';

                updateCase.add(c);
            } else {
                /* case non nuovo né chiuso (eliminati con la query) aggiorno descrizione */
                c.Description += ' modificato in data ' + Date.today().format();

                updateCase.add(c);
            }

            /* Se Subject inizia per "Sollecito", creo case figlio con subject Reclamo*/
            if (c.Subject != null && c.Subject.toLowerCase().startsWith('sollecito')) {
                Case caseSollecito = new Case(
                    Subject = 'Reclamo',
                    ParentId = c.Id
                );

                insertCaseReclami.add(caseSollecito);
            }
        }

        /* aggiorno i case */
        if (!updateCase.isEmpty()) {
            update updateCase;
        }

        /* inserisco i case */
        if (!insertCaseReclami.isEmpty()) {
            insert insertCaseReclami;
        }
    }

    /* metodo finish */
    global void finish(Database.BatchableContext BC) {
        System.debug('Batch eseguito con successo!');
    }
}