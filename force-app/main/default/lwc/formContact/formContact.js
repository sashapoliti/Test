import { LightningElement } from 'lwc';
import addContact from '@salesforce/apex/testAuraContacts.addContact';

export default class FormContact extends LightningElement {
    /* variabili */
    firstName;
    lastName;
    email;
    phone;

    /* metodo al cambio dei value negli input per assegnare variabili */
    cambiaValue(event) {
        this[event.target.name] = event.target.value;
        /* console.log(this[event.target.name]); */
    }

    /* metodo per salvare il contatto */
    createContact() {
        console.log('bottone premuto');

        console.log(this.firstName);
        console.log(this.lastName);
        console.log(this.email);
        console.log(this.phone);        
        
        /* creazione di un contatto */
        let contact = {
            FirstName: this.firstName,
            LastName: this.lastName,
            Email: this.email,
            Phone: this.phone
        };

        console.log(contact);

        /* chiamata apex per creare il contatto */
        addContact({
            nuovo: contact
        })
            .then((result) => {
                console.log(result);

                /* Creo l'evento */
                const event = new CustomEvent('adddone', {
                    detail: 'Contact created successfully'
                });
                this.dispatchEvent(event);

                /* resetto le variabili */
                this.firstName = '';
                this.lastName = '';
                this.email = '';
                this.phone = '';
            })
            .catch((error) => {
                console.error(error);
            });
    }
}