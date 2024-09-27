public with sharing class Esercizio2 {

    public static void Esercizio2() {

        /*  Mappa di dipendenti: nome -> ruolo  */
        Map<String, String> dipendenti = new Map<String, String>{
            'Mario Rossi' => 'Manager',
            'Luigi Bianchi' => 'Developer',
            'Anna Verdi' => 'Developer',
            'Marco Neri' => 'HR',
            'Laura Blu' => 'Manager'
        };
        
        /*  Mappa di ruoli e stipendi: ruolo -> stipendio  */
        Map<String, Integer> stipendi = new Map<String, Integer>{
            'Manager' => 3000,
            'Developer' => 1800,
            'HR' => 2200
        };

        /*  Mappa di dipendenti e stipendi nuova */
        Map<String, Integer> dipendentiStipendi = new Map<String, Integer>();

        /*  Ciclo for per creare mappa nuova */
        for (String dipendente : dipendenti.keySet()) {
            String ruolo = dipendenti.get(dipendente); /* prendo il ruolo rispetto al dipendente */
            Integer stipendio = stipendi.get(ruolo); /* prendo lo stipendio rispetto al ruolo nell'altra mappa */

            /*  Aggiungo i valori alla mappa nuova */
            dipendentiStipendi.put(dipendente, stipendio);
        }

        /*  Stampo i valori della mappa nuova */
        for (String dipendente : dipendentiStipendi.keySet()) {
            System.debug(dipendente + ': ' + dipendentiStipendi.get(dipendente) + '€');
        }


        /*  Aumento lo stipendio a Luigi Bianchi di 300€ e lo stampo*/
        Integer stipendioLuigi = dipendentiStipendi.get('Luigi Bianchi') + 300;
        dipendentiStipendi.put('Luigi Bianchi', stipendioLuigi);
        System.debug('Luigi Bianchi nuovo stipendio: ' + stipendioLuigi + '€');


        /* Mostrare tutti i dipendenti che hanno stipendio > 2000€ */
        for (String dipendente : dipendentiStipendi.keySet()) {
            if (dipendentiStipendi.get(dipendente) > 2000) {
                System.debug(dipendente + ': ' + dipendentiStipendi.get(dipendente) + '€');
            }
        }
    }
}