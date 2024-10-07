public with sharing class TryInvocableMethods {
    @InvocableMethod
    public static List<Account> GetAccountViaApex (List<String> inputs) {
        
        List<Account> accts = [SELECT Id, Name FROM Account WHERE Id = :inputs[0] LIMIT 1];

        return accts;
    }
}