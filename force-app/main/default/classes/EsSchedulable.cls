global with sharing class EsSchedulable implements Schedulable {

    global void execute(SchedulableContext context) {
        /* richiamo batch */
        EsSchedulableBatch batch = new EsSchedulableBatch();
        Database.executeBatch(batch);
    }

    /* nella console lo richiamo con
    String sch = '0 30 12 * * ?';
    System.schedule('UpdateCasesScheduler', sch, new UpdateCasesScheduler());
    per eseguirlo ogni giorno alle 12:30  */
}