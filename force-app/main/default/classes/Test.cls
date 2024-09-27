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
private class Test {

    @isTest
    static void eseguiTest() {
        
        /* creare istanza di Auto e istanza di Moto */
        Auto a1 = new Auto('AA-123-AA', 180, 5);
        Moto m1 = new Moto('BB-123-BB', 120, false);
        
        /* testare i metodi descrivi */
        a1.descrivi();
        m1.descrivi();

        /* creare istanza di una nuova auto e confrontare
        la velocità tra le due */
        Auto a2 = new Auto('ABCDEFG', 140, 4);

        System.debug(Auto.confrontaVelocità(a1, a2));

        /* testare il metodo isEcologico */
        System.debug(a1.isEcologico());
        System.debug(a2.isEcologico());
        System.debug(m1.isEcologico());
        Moto m2 = new Moto('HILMNOP', 120, true);
        System.debug(m2.isEcologico());

    }
}