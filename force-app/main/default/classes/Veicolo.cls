abstract virtual with sharing class Veicolo {
    
    /* attributi privati */
    private String targa;
    private Integer velocitàMassima;

    /* costruttore pubblico che prende targa e velocitàMassima come parametri e li assegna agli attributi. */
    public Veicolo(String targa, Integer velocitàMassima) {
        this.targa = targa;
        this.velocitàMassima = velocitàMassima;
    }

    /* metodi per incapsulamento */
    public String getTarga() {
        return targa;
    }
    public Integer getVelocitàMassima() {
        return velocitàMassima;
    }

    /* metodo astratto da implementare nelle classi figlie */
    public abstract void descrivi();

    /* metodo publico per avviare il motore con targa */
    public void avviaMotore() {
        System.debug('Motore avviato per il veicolo con targa: ' + getTarga());
    }
}