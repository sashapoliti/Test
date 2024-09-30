/* Creare una classe che gestisce le operazioni matematiche:
+, -, *, /

Tramite il metodo esegui(String operazione, Integer a, Integer b)

Gestire il caso di divisione per 0 in un try catch
Lanciare un'eccezione personalizzata nel caso operazione non sia una delle 4 gestibili. */

public with sharing class MathEx {

    public static void esegui(String operazione, Integer a, Integer b) {
        try {
            /* uso switch per gestire le 4 operazioni possibili */
            switch on operazione {
                when '+' {
                    System.debug('La somma tra ' + a + ' e ' + b + ' è ' + (a + b));
                }
                when '-' {
                    System.debug('La differenza tra ' + a + ' e ' + b + ' è ' + (a - b));
                }
                when '*' {
                    System.debug('Il prodotto tra ' + a + ' e ' + b + ' è ' + (a * b));
                }
                when '/' {
                    /* condizione per il caso di divisione per 0 con un try catch */
                    if (b == 0) {
                        throw new MathException('Divisione per 0: impossibile.');
                    }
                    System.debug('Il quoziente tra ' + a + ' e ' + b + ' è ' + (a / b));
                }
                when else {
                    /* gestione dell'eccezione personalizzata per operazione non esistente*/
                    throw new PersException('Operazione ' + operazione + ' non gestibile');
                }
            }
        /* catch del caso di divisione per 0 */
        } catch (MathException e) {
            System.debug(e.getMessage());
        }
    }

    /* testo il metodo esegui nel main */
    public static void main () {
        esegui('+', 3, 5);
        esegui('-', 3, 5);
        esegui('*', 3, 5);
        esegui('/', 3, 5);
        esegui('/', 3, 0);
        esegui('?', 3, 5);
    }

    /* dichiaro le eccezioni come classi che estendono la superclasse Exception
    e terminano anch'esse con Exception nel nome */
    class PersException extends Exception {}
    class MathException extends Exception {}
}