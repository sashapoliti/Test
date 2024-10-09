/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestEsTestClass {

    @isTest static void TestGetDayName() {
        /* verifico che il metodo restituisca il valore corretto */
        System.assertEquals('Lunedì', EsTestClass.getDayName(1));
        System.assertEquals('Martedì', EsTestClass.getDayName(2));
        System.assertEquals('Mercoledì', EsTestClass.getDayName(3));
        System.assertEquals('Giovedì', EsTestClass.getDayName(4));
        System.assertEquals('Venerdì', EsTestClass.getDayName(5));
        System.assertEquals('Sabato', EsTestClass.getDayName(6));
        System.assertEquals('Domenica', EsTestClass.getDayName(7));

        /* verifico numeri non validi */
        System.assertEquals('Numero non valido', EsTestClass.getDayName(11));
    }

    @isTest static void testGetDayNumber() {
        System.assertEquals(1, EsTestClass.getDayNumber('Lunedì'));
        System.assertEquals(2, EsTestClass.getDayNumber('Martedì'));
        System.assertEquals(3, EsTestClass.getDayNumber('Mercoledì'));
        System.assertEquals(4, EsTestClass.getDayNumber('Giovedì'));
        System.assertEquals(5, EsTestClass.getDayNumber('Venerdì'));
        System.assertEquals(6, EsTestClass.getDayNumber('Sabato'));
        System.assertEquals(7, EsTestClass.getDayNumber('Domenica'));
        
        /* verifico giorni non validi */
        System.assertEquals(0, EsTestClass.getDayNumber('ciao'));
    }

    @isTest static void testCreateLead() {
        Id leadId = EsTestClass.createLead(3);
        Lead createdLead = [SELECT Id, LastName FROM Lead WHERE Id = :leadId];
        System.assertEquals('Mercoledì', createdLead.LastName);

        /* verifico numeri non validi */
        System.assertEquals('Numero non valido', EsTestClass.createLead(11));
    }

    @isTest static void testTriggerLead() {
        Lead l = new Lead(
            LastName = 'Test',
            Company = 'Test Company'
        );
        insert l;

        /* cerco l'asset creato dal trigger */
        List<Asset> a = [SELECT Id, Name FROM Asset WHERE Name = 'Asset per prova classi test'];
        System.assert(!a.isEmpty() && a[0].AccountId == '001Qy00000XKAMKIA5');
    }
}