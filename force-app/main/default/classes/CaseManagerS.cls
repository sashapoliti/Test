global with sharing class CaseManagerS {

		/* espongo la classe come servizio SOAP
        recupera un case da id passato */
        webservice static Case getCaseById(Id caseId) {
            if (caseId != null) {
                Case c = [SELECT Id, Status, Origin, Subject FROM Case WHERE Id = :caseId];
                return c;
            }
            return null;        
        }
    
        /* espongo la classe come servizio SOAP
        crea un case con parametri dati
        restituisco l'id */
        webservice static Id createCase(String status, String origin, String subject, String priority) {
            /* inserire eventualmente validazioni e controlli suoi campi */
            Case c = new Case(
                Status = status,
                Origin = origin,
                Subject = subject,
                Priority = priority
            );
            insert c;
            return c.Id;
        }
    
        /* espongo la classe come servizio SOAP
        delete del case da id
        non restituisco nulla */
        webservice static void deleteCase(Id caseId) {
            if (caseId != null) {
                Case c = new Case(
                    Id = caseId
                );
                delete c;
            }
        }
    
        /* espongo la classe come servizio SOAP
        upsert di un case da id e parametri dati
        restituisco l'id del case creato o aggiornato */
        webservice static Id upsertCase(Id caseId, String status, String origin, String subject, String priority) {
            /* inserire eventualmente validazioni e controlli sui campi */
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
    
        /* espongo la classe come servizio SOAP
        update di un case da id e parametri dati
        restituisco l'id del case aggiornato */
        webservice static Id updateCase(Id caseId, String status, String priority) {
            /* inserire eventualmente validazioni e controlli sui campi */
            if (caseId != null) {
                Case c = new Case(
                    Id = caseId,
                    Status = status,
                    Priority = priority
                );
                update c;
                return c.Id; 
            }
            return null;        
        }
}