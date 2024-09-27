public with sharing class Esercizio1 {

    /* ciclo for */
    public static void TestFor(Integer year, Integer month, Integer day, String name) {
        Date myDate = Date.newInstance(year, month, day); /* creo la data */
        Integer nDays = Math.abs(myDate.daysBetween(Date.today())); /* calcolo giorni fino ad oggi e rendilo positivo */

        for (Integer i = 1; i <= nDays; i++) {
            /* salta il 10 */
            if (i == 10) {
                continue;
            }

            /* se i giorni sono pari o dispari */
            if (EvenOrOdd(i)) {
                System.debug(name.toUpperCase());
            } else {
                System.debug(name.toLowerCase());
            }
            
            /* stop prima del 30 */
            if (i == 29) {
                break;
            }
        }
    }

    /* ciclo while */
    public static void TestWhile(Integer year, Integer month, Integer day, String name) {
        Date myDate = Date.newInstance(year, month, day);
        Integer nDays = Math.abs(myDate.daysBetween(Date.today()));

        Integer i = 1; /* inizializzo contatore */
        /* condizione per andare avanti nei giorni ma fino al 30 */
        while (i <= nDays && i < 30) {
            /* salta il 10 */
            if (i == 10) {
                i++;
                continue;
            }

            /* se i giorni sono pari o dispari */
            if (EvenOrOdd(i)) {
                System.debug(name.toUpperCase());
            } else {
                System.debug(name.toLowerCase());
            }

            i++;
        }
    }

    /* funzioncina per pari o dispari */
    public static Boolean EvenOrOdd(Integer x) {
        /* Uso Math.floor
        [Un numero è pari se la divisione per 2 dà lo stesso valore di quando viene troncata (senza parte decimale)] 
        perché l'operatore % non è presente in Apex*/
        if (Math.floor(x / 2.0) == (x / 2.0)) {
            return true; /* Caso pari */
        } else {
            return false; /* Caso dispari */
        }
    }
}