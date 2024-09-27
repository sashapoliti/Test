public abstract with sharing class Veicolo {
    
    /* attributi privati */
    private String targa;
    private Integer velocitaMassima;

    /* costruttore pubblico che prende targa e velocitàMassima come parametri e li assegna agli attributi. */
    public Veicolo(String targa, Integer velocitaMassima) {
        this.targa = targa;
        this.velocitaMassima = velocitaMassima;
    }

    /* metodi per incapsulamento */
    public String getTarga() {
        return targa;
    }
    public Integer getVelocitaMassima() {
        return velocitaMassima;
    }

    /* metodo astratto da implementare nelle classi figlie */
    public abstract void descrivi();

    /* metodo publico per avviare il motore con targa */
    public void avviaMotore() {
        System.debug('Motore avviato per il veicolo con targa: ' + getTarga());
    }
}