public with sharing class EsTestClass {
    
    /* getDayName(Integer d): restituisce il giorno della settimana corrispettivo a d (1-lun, 2-mar etc.) */
    public static String getDayName(Integer d) {
        switch on d {
            when 1 {
                return 'Lunedì';
            }
            when 2 {
                return 'Martedì';
            }
            when 3 {
                return 'Mercoledì';
            }
            when 4 {
                return 'Giovedì';
            }
            when 5 {
                return 'Venerdì';
            }
            when 6 {
                return 'Sabato';
            }
            when 7 {
                return 'Domenica';
            }
            when else {
                return 'Numero non valido';
            }
        }
    }

    /* getDayNumber(String n): il contrario di sopra */
    public static Integer getDayNumber(String n) {
        switch on n {
            when 'Lunedì' {
                return 1;
            }
            when 'Martedì' {
                return 2;
            }
            when 'Mercoledì' {
                return 3;
            }
            when 'Giovedì' {
                return 4;
            }
            when 'Venerdì' {
                return 5;
            }
            when 'Sabato' {
                return 6;
            }
            when 'Domenica' {
                return 7;
            }
            when else {
                return 0;
            }
        }
    }

    /* createLead(Integer d): crea un lead con last name = getDayName(d) */
    public static String createLead(Integer d) {
        Lead l = new Lead(
            LastName = getDayName(d),
            Company = 'Test Company'
        );
        if (l.LastName != 'Numero non valido') {
            insert l;
            return l.Id;
        } else {
            return l.lastName;
        }        
    }
}