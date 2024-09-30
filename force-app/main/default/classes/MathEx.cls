/* Creare una classe che gestisce le operazioni matematiche:
+, -, *, /

Tramite il metodo esegui(String operazione, Integer a, Integer b)

Gestire il caso di divisione per 0 in un try catch
Lanciare un'eccezione personalizzata nel caso operazione non sia una delle 4 gestibili. */

public with sharing class MathEx {

    public static void esegui(String operazione, Integer a, Integer b) {
        try {
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
                    if (b == 0) {
                        throw new MathException('Divisione per 0: impossibile.');
                    }
                    System.debug('Il quoziente tra ' + a + ' e ' + b + ' è ' + (a / b));
                }
                when else {
                    throw new PersException('Operazione ' + operazione + ' non gestibile');
                }
            }
        } catch (MathException e) {
            System.debug(e.getMessage());
        }
    }

    public static void main () {
        esegui('+', 3, 5);
        esegui('-', 3, 5);
        esegui('*', 3, 5);
        esegui('/', 3, 5);
        esegui('/', 3, 0);
        esegui('?', 3, 5);
    }

    class PersException extends Exception {}
}