/* Scrivi un trigger su **Case** che, quando un caso viene chiuso (valore del campo **Status** uguale a "Closed"),
verifichi se esistono opportunità aperte (con **StageName** diverso da "Closed Won" o "Closed Lost") collegate allo stesso account.
Se esistono opportunità aperte, aggiorna il campo **Description** delle opportunità indicando che un caso associato è stato chiuso, includendo il numero del caso. */

trigger EsCase on Case (after update) {

    /* Creo una lista di Opportunità da aggiornare */
    List <Opportunity> updateOpportunity = new List <Opportunity> ();

    for (Case c : Trigger.new) {
        /* Controllo venga chiuso e non era già chiuso */
        if (c.Status == 'Escalated' && Trigger.OldMap.get(c.Id).Status != 'Escalated') {
          /* Controllo che sia stata associata ad un account */
          if (c.AccountId != null) {

            /* Query per le opportunità aperte collegate all'account */
            List <Opportunity> opp = [
                SELECT Id, OrderNumber__c, Description
                FROM Opportunity
                WHERE AccountId = :c.AccountId
                AND StageName != 'Closed Won'
                AND StageName != 'Closed Lost'
            ];

            /* Controllo la query non sia vuota */
            if (!opp.isEmpty()) {
                for (Opportunity o : opp) {
                    new Opportunity(
                        Id = o.Id,
                        Description = 'Il caso associato numero ' + o.OrderNumber__c + ' è stato chiuso'
                    );

                    updateOpportunity.add(o);
                }             
            }
          }  
        }
    }

    /* Controllo la lista non sia vuota e faccio update */
    if (!updateOpportunity.isEmpty()) {
        update updateOpportunity;        
    }
}