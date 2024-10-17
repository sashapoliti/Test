public with sharing class ControllerProva {

    /* attributi */
    public List<Contact> contacts { get; set; }
    public Contact newContact { get; set; }
    public Id contactId { get; set; }

    /* costruttore */
    public ControllerProva() {
        contacts = getContacts();
        newContact = new Contact();
    }
    
    /* metodo per prendere tutti i contact */
    public List<Contact> getContacts() {
        contacts = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact];
        return contacts;
    }

    /* metodo per creare un nuovo contatto */
    public void createContact() {
        try {
            insert newContact;
            newContact = new Contact();  /* reset per un nuovo inserimento */
            getContacts();
        } catch (Exception e) {
            System.debug(e);
        }
    }

    /* metodo per eliminare un contatto */
    public void deleteContact() {
        try {
            Contact c = new Contact(Id = contactId);
            delete c;
            contactId = null;
            getContacts();
        } catch (Exception e) {
            System.debug(e);
        }
    }
}