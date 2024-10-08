trigger EsTestClassTrigger on Lead (after insert) {

    /* lista di Asset per l'inserimento */
    List <Asset> assetInsert = new List <Asset> ();

    for (Lead l : Trigger.new) {
        Asset a = new Asset(
            Name = 'Asset per prova classi test',
            AccountId = '001Qy00000XKAMKIA5' /* è required */
        );

        assetInsert.add(a);
    }

    if (!assetInsert.isEmpty()) {
        insert assetInsert;        
    }
}