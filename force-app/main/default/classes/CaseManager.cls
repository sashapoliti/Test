@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    
    /* primo metodo get che recupera il Case dall'Id passato */
    @HttpGet
    global static Case getCaseById() {
        /* mi prendo la request */
        RestRequest req = RestContext.request;
        /* mi prendo l'id facendo substrings prendendo quello che c'è dopo l'ultimo / dell'url */
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        /* mi prendo il case con la query */
        Case c = [SELECT Id, Status, Origin, Subject FROM Case WHERE Id = :caseId];

        return c;
    }

    /* secondo metodo deve con post creare un Case con parametri dati, restituendo solo l'id */
    @HttpPost
    global static Id createCase(String status, String origin, String subject, String priority) {
        /* creo il case */
        Case c = new Case(
            Status = status,
            Origin = origin,
            Subject = subject,
            Priority = priority
        );
        insert c;

        /* restituisco l'id generato dopo averlo inserito */
        return c.Id;
    }

    /* terzo metodo deve fare delete di un case con id passato */
    @HttpDelete
    global static void deleteCase() {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Case c = [SELECT Id FROM Case WHERE Id = :caseId];
        delete c;
    }

    /* quarto metodo con put crea e sovraschivere i campi subject, status, origin e priority di un case
    ritorna l'id del case aggiornato/creato */
    @HttpPut
    global static Id upsertCase(String status, String origin, String subject, String priority) {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        Case c = new Case(
            Id = caseId,
            Status = status,
            Origin = origin,
            Subject = subject,
            Priority = priority
        );
        upsert c;

        return c.Id;
    }

    /* quinto metodo con patch aggiorna i campi, status e priority di un case
    ritorna l'id del case aggiornato*/
    @HttpPatch
    global static Id updateCase(String status, String priority) {
        RestRequest req = RestContext.request;
        String caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        Case c = new Case(
            Id = caseId,
            Status = status,
            Priority = priority
        );
        update c;

        return c.Id;
    }
}