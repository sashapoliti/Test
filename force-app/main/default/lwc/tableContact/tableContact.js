import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/testAuraContacts.getContacts';

export default class TableContact extends LightningElement {

    contactsList;

    /* metodo che si richiama al caricamento del componente */
    connectedCallback() {
        this.prendiamoContatti();
    }

    /* metodo per recuperare i contatti */
    prendiamoContatti() {
        getContacts()
            .then(result => {
                /* riempio la variabile */
                this.contactsList = result;
            })
            .catch(error => {
                console.log(error);
            });
    }
}