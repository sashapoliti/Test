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