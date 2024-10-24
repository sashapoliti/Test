({
	fillTableHelper : function(component, event) {
		let action = component.get("c.getContacts");
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state == "SUCCESS") {
				component.set("v.contactsEl", response.getReturnValue());
			}
		});
		$A.enqueueAction(action);
	},

	createContactHelper : function(component, event) {
		console.log('ciao');
		console.log(component.get("v.newContact"));		
		let action = component.get("c.addContact");
		action.setParams({
			"nuovo" : component.get("v.newContact")
		});
		action.setCallback(this, function(response) {
			let state = response.getState();
			if(state === "SUCCESS") {
				console.log('Contatto creato con successo');
				/* riempio la tabella di nuovo e
				resetto l'attribute */
				this.fillTableHelper(component, event);
				component.set("v.newContact", {
					"sObjectType": "Contact",
					"FirstName": "",
					"LastName": "",
					"Email": "",
					"Phone": ""
				})
			} else if(state === "ERROR") {
				let errors = response.getError();
				console.error(errors);
			}
		});
		$A.enqueueAction(action);
	},

	deleteContactHelper : function(component, event) {
		let action = component.get("c.deleteContactController");
		action.setParams({
			"contactId" : event.getSource().get("v.value")
		});
		action.setCallback(this, function(response) {
			let state = response.getState();
			if(state === "SUCCESS") {
				this.fillTableHelper(component, event);
			} else if(state === "ERROR") {
				let errors = response.getError();
				console.error(errors);
			}
		});
		$A.enqueueAction(action);
	}
})