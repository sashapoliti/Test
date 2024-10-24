public with sharing class EsAuraMethods {

    @AuraEnabled
    public static Account addAccount(String name, String phone) {
        Account a = new Account(
            Name = name,
            Phone = phone
        );
        insert a;

        return a;
    }

    @AuraEnabled
    public static void deleteAccount(Id accountId) {
        System.debug(accountId);
        delete new Account(Id = accountId);
    }
}