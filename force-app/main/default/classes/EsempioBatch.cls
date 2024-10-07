global with sharing class EsempioBatch implements Database.Batchable<sObject> {
    global String [] email = new String [] {'tuamail@mail.org'};

    /* metodo start per preparare il batch e 
    prendere i dati da elaborare */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Name, Active__c, Description FROM Account WHERE Name = \'ciao\'');
    }

    /* metodo execute per elaborare i dati */
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Account> accountList = new List<Account>();
        List<Account> updatedAccountList = new List<Account>();

        for (sObject objScope : scope) {
            Account newObjScope = (Account) objScope;

            newObjScope.Description = 'Aggiornato con batch apex';
            newObjScope.Phone = 123;

            updatedAccountList.add(newObjScope); // Add records to the List
            System.debug('Value of updatedAccountList ' + updatedAccountList);
        }

        if (updatedAccountList != null && updatedAccountList.size() > 0) {
            // Check if List is empty or not
            Database.update(updatedAccountList);
            System.debug('List Size ' + updatedAccountList.size());
            // Update the Records
        }
    }
}