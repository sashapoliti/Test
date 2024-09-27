public class AgeChecker {
    
    public static void checkAge(Integer x){
        if (x >= 18) {
            system.debug('maggiorenne');
        } else if (x >= 0) {
            system.debug('minorenne');
        } else {
            system.debug('eta non valida');
        }
    }
}