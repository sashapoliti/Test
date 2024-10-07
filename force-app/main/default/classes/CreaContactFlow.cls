public with sharing class CreaContactFlow {
    public class ContactInput {
        @InvocableVariable(Label = 'Nome Contatto' Description = 'Inserisci nome contatto')
        public String nome;
        @InvocableVariable(Label = 'Cognome Contatto' Description = 'Inserisci cognome contatto' required = true)
        public String cognome;
    }

    public class ContactOutput {
        @InvocableVariable(Label = 'Contatto' Description = 'Contatto inserito')
        public Contact contatto;
    }



    @InvocableMethod(Label = 'Inserisci contatto' Description = 'Inserisci nome e cognome del contatto')
    public static List<ContactOutput> creaContatto (List<ContactInput> input) {
        List<ContactOutput> l = new List<ContactOutput>();
        ContactOutput o = new ContactOutput();
        o.contatto = crea(input[0].nome, input[0].cognome);
        l.add(o);
        return l; /* dato che in input diamo una lista, Apex in return rivuole una lista di medesima lunghezza */
    }

    private static Contact crea(String nome, string cognome) {
        Contact c = new Contact();
        c.FirstName = nome;
        c.LastName = cognome;
        insert c;
        return c;
    }
}