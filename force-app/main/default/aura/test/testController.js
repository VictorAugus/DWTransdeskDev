({
	handleClick : function(component, event, helper) {
		 var flow = component.find("flowId")
        flow.startFlow("ConverterLead" , [
        {
            name : 'recordId',
            type : 'String',
            value : component.get("v.recordId")
        }
        ]);
	}
})