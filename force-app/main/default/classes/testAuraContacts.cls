public with sharing class testAuraContacts {
    
    @AuraEnabled
    public static List<Contact> getContacts() {
        return [SELECT Id, FirstName, LastName, Email, Phone FROM Contact ORDER BY Id DESC];
    }

    @AuraEnabled
    public static void addContact(Contact nuovo) {
        System.debug(nuovo);
        insert nuovo;
    }

    @AuraEnabled
    public static void deleteContactController(Id contactId) {
        System.debug(contactId);
        delete new Contact(Id = contactId);
    }
}