public with sharing class ControllerProva {

    /* attributi */
    public List<Contact> contacts { get; set; }
    public Contact newContact { get; set; }

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
}