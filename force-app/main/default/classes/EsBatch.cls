global with sharing class EsBatch implements Database.Batchable<sObject> {

    /* metodo start sui contact, con query where name like 'test%' */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Name, AccountId, Phone FROM Contact WHERE Name LIKE \'test%\'');
    }

    /* metodo execute per aggiornare il campo Phone del COntact,
    aggiornare anche il campo description dell'account associato,
    creare un case se becca un account più volte*/
    global void execute(Database.BatchableContext BC, List<sObject> scope) {

        List<Contact> contactList = new List<Contact>();
        Map<Id, Account> accountMap = new Map<Id, Account>();
        List<Case> caseList = new List<Case>();

        for (sObject objScope : scope) {
            Contact newObjScope = (Contact) objScope;
            newObjScope.Phone = '123';

            contactList.add(newObjScope); /* modifico il campo Phone e aggiungo alla lista */

            /* controllo se il contact ha un account associato */
            if (newObjScope.AccountId != null) {
                
                /* aggiorno la description dell'account,
                ma se è un  già modificato, creo un case associato all'account */
                if (!accountMap.containsKey(newObjScope.AccountId)) {
                    Account a = new Account(
                        Id = newObjScope.AccountId,
                        Description = 'Aggiornato con batch apex'
                    );
                    accountMap.put(newObjScope.AccountId, a);
                } else {
                    Case c = new Case(
                        AccountId = newObjScope.AccountId,
                        Subject = 'Già aggiornato con batch apex'
                    );
                    caseList.add(c);
                }
            }
        }

        if (!contactList.isEmpty()) {
            update contactList;            
        }

        if (!accountMap.isEmpty()) {
            update accountMap.values();
        }

        if (!caseList.isEmpty()) {
            insert caseList;
        }
    }

    /* metodo finish creare un case con subject = "Batch eseguito in data " + today e description
    'The Batch Apex job processed ' + a.TotalJobItems + ' with ' + a.NumberOfErrors + ' failures.' + 
    ' Job Item processed are ' + a.JobItemsProcessed*/
    global void finish(Database.BatchableContext BC) {

        /* Prendo per buona */
        AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors,
            a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,
            a.CompletedDate From AsyncApexJob a WHERE id = :BC.getJobId()];
        System.debug('### Jobid is='+BC.getJobId());

        /* Creo il case */
        insert new Case(
            Subject = 'Batch eseguito in data ' + Date.today(),
            Description = 'The Batch Apex job processed ' + a.TotalJobItems + ' with ' + a.NumberOfErrors + ' failures.' + ' Job Item processed are ' + a.JobItemsProcessed
        );
    }
}