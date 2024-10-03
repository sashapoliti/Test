/* Scrivi un trigger su **Quote** che impedisca qualsiasi aggiornamento del record se il campo **Status** del preventivo è impostato su "Approved".
Se un utente prova a modificarlo, il trigger deve bloccare l'operazione e restituire un errore che informi l'utente che non è possibile aggiornare preventivi approvati.
Assicurati di gestire correttamente i tentativi di aggiornamento in massa */

trigger EsQuote on Quote (before update) {

    for (Quote q : Trigger.new) {
        if (q.Status == 'Approved') {
            /* Blocca il record con un errore, quelli non approvati potranno essere modificati
            in un tentativo di aggiornamento di massa */
            q.addError('Non si possono modificare preventivi che sono stati approvati');
        }
    }
}