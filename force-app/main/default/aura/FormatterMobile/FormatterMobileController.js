({
	
    verifyPhone : function(component, event, helper) {
       
        document.getElementById('celularInput').addEventListener('input', function (e) {
            var x = e.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
            e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
        });
        
    },
    endCellPhone : function(component, event, helper) {
        let celular = document.getElementById("celularInput").value;
        console.log('celular',celular)
        component.set("v.mobile",celular)
    },
    keypfunc : function(component, event, helper) {
	 document.getElementById('celularInput').addEventListener('input', function (e) {
            var x = e.target.value.replace(/\D/g, '').match(/(\d{0,2})(\d{0,5})(\d{0,4})/);
            e.target.value = !x[2] ? x[1] : '(' + x[1] + ') ' + x[2] + (x[3] ? '-' + x[3] : '');
        });    }
    
})