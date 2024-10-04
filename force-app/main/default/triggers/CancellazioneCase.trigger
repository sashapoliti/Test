trigger CancellazioneCase on Case (after insert) {

        List<Case> casesToInsert = new List<Case>();
    
        for (Case c : Trigger.new) {
            /* Controlla se è un case di cancellazione */
            if (c.Subject == 'Cancellazione') {
                /* Creazione di un case di avvenuta cancellazione */
                Case followUpCase = new Case(
                    Subject = 'Avvenuta cancellazione contatto',
                    ParentId = c.Id  /* Relazione con il case di cancellazione */
                    /* ContactId = c.ContactId */
                );
                casesToInsert.add(followUpCase);
            }
        }
    
        /* Inserisce il case figlio */
        if (!casesToInsert.isEmpty()) {
            insert casesToInsert;
        }
}