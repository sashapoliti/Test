/* trigger su contact che:
    - all’inserimento:
            - crea un case di benvenuto
            - se il cognome è ‘apicella’ lo modifica con ‘rossi’
    - alla modifica:
            - se il cognome nuovo è ‘rossi’ e il cognome vecchio non è ‘apicella’ setta il nome a ‘mario’
            - crea un case di modifica
    - alla cancellazione:
            - crea un case di cancellazione

- i case devono avere il contact correlato

- trigger su case che:
    - all’inserimento:
            - se è un case di cancellazione crea un altro case figlio di avvenuta cancellazione */

trigger Benvenuto on Contact (before insert, after insert, before update, after update, before delete, after delete) {
    List <Case> casiDaInserire = new List <Case> (); /* creo una lista di case da inserire */

    /* prima dell'inserimento modifico il cognome da Apicella a Rossi */
    if (Trigger.isBefore && Trigger.isInsert) {
        for (Contact c : Trigger.new) {
            if (c.LastName == 'Apicella') {
                c.LastName = 'Rossi';
            }
        }
    }
    /* dopo l'inserimento devo creare un case di benvenuto */
    if (Trigger.isAfter && Trigger.isInsert) {

        /* ciclo for per ogni contatto che ora possiede ID (siamo in afer insert) e creare
        case di benvenuto */
        for (Contact c : Trigger.new) {
            /* creo un case di benvenuto */
            Case caseBenvenuto = new Case(
                ContactId = c.Id,
                Subject = 'Benvenuto ' + c.FirstName + ' ' + c.LastName
            );

            casiDaInserire.add(caseBenvenuto); /* lo aggiungo alla lista */
        }
    }

    /* prima della modifica se il cognome nuovo è "Rossi" e il vecchio non è "Apicella", metto di nome "Mario" */
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Contact c : Trigger.new) {
            Contact triggerOldContact = Trigger.oldMap.get(c.Id); /* recuper il contatto prima della modifica */

            if (c.LastName == 'Rossi' && triggerOldContact.LastName != 'Apicella') {
                c.FirstName = 'Mario'; /* cambio nome */
            }
        }
    }
    /* dopo la modifica devo creare un case di modifica */
    if (Trigger.isAfter && Trigger.isUpdate) {

        for (Contact c : Trigger.New) {
            /* creo case di modifica */
            Case caseDiModifica = new Case (
                ContactId = c.Id,
                Subject = 'Modifica' + c.FirstName + ' ' + c.LastName
            );

            casiDaInserire.add(caseDiModifica); /* lo aggiungo alla lista */
        }
    }

    /* alla canceazione devo creare un case di cancellazione */
    if (Trigger.isDelete) {

        for (Contact c : Trigger.old) {
            /* creo case di cancellazione */
            Case caseDiCancellazione = new Case (
                /* ContactId = c.Id, */
                Subject = 'Cancellazione ' + c.FirstName + ' ' + c.LastName
            );

            casiDaInserire.add(caseDiCancellazione); /* lo aggiungo alla lista */
        }
    }

    if (!casiDaInserire.isEmpty()) {
        insert casiDaInserire;            
    }
}