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
}