public with sharing class ContactAllClass {

    @AuraEnabled
    public static List <Contact> getContacts(String searchTerm) {
        List <Contact> contacts = [
            SELECT Id, FirstName, LastName, Email
            FROM Contact
            WHERE Name LIKE :('%' + searchTerm + '%')
        ];

        return contacts;
    }

    @AuraEnabled
    public static List <Contact> deleteContacts(Id contactId, String search) {
        Contact contact = new Contact(Id = contactId);
        System.debug(contact);
        delete contact;

        return getContacts(search);
    }
}