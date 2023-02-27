({
	handleClick : function(component, event, helper) {
		 var flow = component.find("flowId")
        flow.startFlow("Fl_Reatribuir_Data_Renovacao" , [
        {
            name : 'recordId',
            type : 'String',
            value : component.get("v.recordId")
        }
        ]);
	}
})