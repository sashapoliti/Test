public with sharing class EsFlowTrigger {
    
    /* sottoclasse per raccogliere l'account in input */
    public class AccountInput {
        @InvocableVariable
        public Account account;
    }

    @InvocableMethod
    /* metodo invocabile per modificare il cognome del contatto
    associato, se non ne trova crearne uno nuovo con
    cognome = nome dell'account */
    public static void insertAccount(List<AccountInput> input) {

        /* lista di account create */
        List<Account> accCreate = new List<Account> ();
        /* lista di account update */
        List<Account> accUpdate = new List<Account> ();

        /* capire se l'account è stato creato o updated(esiste già?) 
        controllo data di creazione e quella di modifica*/
        for (AccountInput a : input) {
            if (a.account.CreatedDate == a.account.LastModifiedDate) {
                accCreate.add(a.account);
            } else {
                accUpdate.add(a.account);
            }
        }

        /* se la lista create non è vuota, metodo della creazione */
        if (!accCreate.isEmpty()) {
            createContacts(accCreate);
        }
        
        /* se la lista update non è vuota, metodo di aggiornamento */
        if (!accUpdate.isEmpty()) {
            updateContacts(accUpdate);
        }
    }

    /* metodo per la creazione dei contatti */
    private static void createContacts(List<Account> accCreate) {

        /* lista di contatti da creare */
        List<Contact> conCreate = new List<Contact> ();
        /* creo i contatti nuovi da inserire */
        for (Account a : accCreate) {
            Contact c = new Contact();
            c.AccountId = a.Id;
            c.LastName = a.Name;
            conCreate.add(c);
        }

        /* inserisco i contatti senza controllo, se la Lista Account
        fosse vuota, questo metodo non verrebbe neanche usato*/
        insert conCreate;
    }

    /* metodo per l'aggiornamento */
    private static void updateContacts(List<Account> accUpdate) {

        /* lista di contatti da aggiornare */
        List<Contact> conUpdate = new List<Contact> ();

        /* lista di contatti da creare */
        List<Contact> conCreate = new List<Contact> ();

        /* creo lista di id di account*/
        List<Id> accId = new List<Id> ();
        for (Account a : accUpdate) {
            accId.add(a.Id);
        }

        /* mappa con l'id dell'account e i contatti relativi*/
        Map<Id, Contact> contactMap = new Map<Id, Contact> (
            [SELECT Id, Name, AccountId FROM Contact WHERE AccountId IN :accId]
        );

        /* aggiorno le liste */
        for (Account a : accUpdate) {

            Contact contact = contactMap.get(a.Id);

            /* se questo account ha un contatto associato, aggiorno */
            if (contact != null) {
                contact.LastName = a.Name;
                conUpdate.add(contact);
            } else {
                /* altrimenti, creo un nuovo contatto da insert */
                Contact c = new Contact();
                c.AccountId = a.Id;
                c.LastName = a.Name;
                conCreate.add(c);
            }            
        }
        /* aggiorno i contatti */
        if (!conUpdate.isEmpty()) {
            update conUpdate;
        }

        /* creo i nuovi contatti */
        if (!conCreate.isEmpty()) {
            insert conCreate;
        }
    }        
}