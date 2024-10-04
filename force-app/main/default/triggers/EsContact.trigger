/* Scrivi un trigger su **Contact** che, quando un contatto viene inserito o aggiornato con il campo **Email** valorizzato,
verifichi se esistono già contatti con la stessa email nell'organizzazione.
Se esistono duplicati, il trigger deve bloccare l'operazione e restituire un errore che informi l'utente che l'email è già in uso da un altro contatto. */

trigger EsContact on Contact (before insert, before update) {

    /* Creo un set di email per non inserire duplicati */
    set <string> emailControllo = new set <string> ();

    /* Ci aggiungo le email di tutti i contatti inseriti o modificati */
    for (Contact c : Trigger.new) {
        /* controllo che il campo email ci sia */
        if (c.Email != null) {
            emailControllo.add(c.Email);          
        }
    }

    /* Controllo se ci sono email da controllare */
    if (!emailControllo.isEmpty()) {
        /* Query per i contatti con la stessa email in map (così posso prendere Email facilmente)*/
        List <Contact> contattiDuplicati = [
            SELECT Id, Email
            FROM Contact
            WHERE Email IN :emailControllo
        ];

        /*  Creo una mappa con le email come chiave e i contatti come valore */
        Map<String, Contact> emailMap = new Map<String, Contact>();
        for (Contact c : contattiDuplicati) {
            emailMap.put(c.Email, c);
        }

        /* Controllo la query non sia vuota */
        if (!emailMap.isEmpty()) {
            for (Contact c : Trigger.new) {
                /* controllo se la mail esiste,  se l'email è contenuta nelle chiavi della mappatura precedente,
                e se l'id del contatto non è uguale a quello presente nella mappatura (in quel caso è update su sé stesso) */
                if (c.Email != null && emailMap.containsKey(c.Email) && emailMap.get(c.Email).Id != c.Id) {
                    c.addError('L\'email ' + c.Email + ' è in uso da un altro contatto');                    
                }
            }
        }
    }
}