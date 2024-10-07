global with sharing class EsempioBatch implements Database.Batchable<sObject> {
    global String [] email = new String [] {'sas.politi@gmail.com'};

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
            newObjScope.Phone = '123';

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

    /* metodo finish per terminare il batch */
    global void finish(Database.BatchableContext BC) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Below code will fetch the job Id
        AsyncApexJob a = [Select a.TotalJobItems, a.Status, a.NumberOfErrors,
            a.JobType, a.JobItemsProcessed, a.ExtendedStatus, a.CreatedById,
            a.CompletedDate From AsyncApexJob a WHERE id = :BC.getJobId()];

        // get the job Id
        System.debug('### Jobid is='+BC.getJobId());

        // below code will send an email to User about the status
        mail.setToAddresses(email);
        mail.setReplyTo('test@test.com'); // Add here your email address
        mail.setSenderDisplayName('Apex Batch Processing Module');
        mail.setSubject('Batch Processing '+a.Status);
        mail.setPlainTextBody('The Batch Apex job processed ' +
            a.TotalJobItems + ' with ' + a.NumberOfErrors + ' failures.' +
            ' Job Item processed are ' + a.JobItemsProcessed);
        Messaging.sendEmail(new Messaging.SingleEmailMessage [] {mail});
    }
}