public with sharing class Auto extends Veicolo implements EcoFriendly {

    /* attributo privato */
    private Integer numeroPorte;

    /* costruttore che chiama il costruttore della classe padre */
    public Auto(String targa, Integer velocitàMassima, Integer numeroPorte) {
        super(targa, velocitàMassima);
        this.numeroPorte = numeroPorte;
    }

    /* metodi per incapsulamento */
    public Integer getNumeroPorte() {
        return numeroPorte;
    }
    public void setNumeroPorte(Integer numeroAssegnato) {
        this.numeroPorte = numeroAssegnato;
    }

    /* metodo implementato dalla classe padre */
    public override void descrivi() {
        System.debug('Auto con targa ' + getTarga() + ', velocità massima ' + getVelocitàMassima() + ' km/h e ' + getNumeroPorte() + ' porte.');
    }

    /* metodo statica che confronta le velocità massime di
    due auto e restituisce quella con velocità più alta*/
    public static String confrontaVelocità(Auto a1, Auto a2) {
        if (a1.getVelocitàMassima() > a2.getVelocitàMassima()) {
            return 'Il veoicolo con targa ' + a1.getTarga() + ' è più veloce';
        } else {
            return 'Il veoicolo con targa ' + a2.getTarga() + ' è più veloce';
        }
    }

    /* metodo dell'interfaccia EcoFriendly che restituisce
    true solo se la velocità massima è inferiore a 150 */
    public Boolean isEcologico() {
        return getVelocitàMassima() < 150;
    }
}