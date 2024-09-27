public with sharing class Moto extends Veicolo implements EcoFriendly {

    /* attributo privato */
    private Boolean haCarrello;

    /* costruttore che chiama il costruttore della classe padre */
    public Moto(String targa, Integer velocitaMassima, Boolean haCarrello) {
        super(targa, velocitaMassima);
        this.haCarrello = haCarrello;
    }

    /* metodi per incapsulamento */
    public Boolean getHaCarrello() {
        return haCarrello;
    }
    public void setHaCarrello(Boolean haCarrelloAssegnato) {
        this.haCarrello = haCarrelloAssegnato;
    }

    /* metodo implementato dalla classe padre */
    public override void descrivi() {
        System.debug('Moto con targa ' + getTarga() + ', velocità massima ' + getVelocitaMassima() + ' km/h, con carrello: ' + getHaCarrello() + '.');
    }

    /* metodo dell'interfaccia EcoFriendly che restituisce true
    se non ha il carrello */
    public Boolean isEcologico() {
        return !getHaCarrello();
    }
}