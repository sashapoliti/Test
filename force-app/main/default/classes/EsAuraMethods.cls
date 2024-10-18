public with sharing class EsAuraMethods {

    @AuraEnabled
    public static void addAccount(String name, String phone) {
        Account a = new Account(
            Name = name,
            Phone = phone
        );
        insert a;
    }

    @AuraEnabled
    public static void deleteAccount(String accountId) {
        delete new Account(Id = accountId);
    }
}