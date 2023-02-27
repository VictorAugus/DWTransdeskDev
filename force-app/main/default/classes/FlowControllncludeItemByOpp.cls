public class FlowControllncludeItemByOpp {
    @InvocableMethod
    public static List<FlowOutput> runControll(List<FlowInput> flowInputList){
        List<FlowOutput> flowOutputList = new List<FlowOutput>();
        List<AnoValor__c> anoValorList = new List<AnoValor__c>();
        List<Marca__c> marcaList = new List<Marca__c>();
		List<Modelo__c> modeloList = new List<Modelo__c>();
        for (FlowInput flowInput : flowInputList){
            if (flowInput.batch == 'getAnoByName'){
                Map<String,AnoValor__c> anovalorMapByName = new Map<String,AnoValor__c>();
                Map<Id,AnoValor__c> anoValorMap =  NEW Map<Id,AnoValor__c>([
                    SELECT ID,Name FROM AnoValor__c ORDER BY Name ASC
                ]);
                
                for(AnoValor__c anoValor : anoValorMap.values()){
                    anovalorMapByName.put(anoValor.Name,anoValor);
                }
                
                anoValorList.addAll(anovalorMapByName.values());
            }
            else if (flowInput.batch == 'getMarcaByAnoAndModel'){
                Map<String,Marca__c> marcaMapByName = new Map<String,Marca__c>();
                
                String ano = '%'+flowInput.anoSelecionado+'%';
                Map<Id,Modelo__c> modeloMap =  NEW Map<Id,Modelo__c>([
                   select id,AnoFormula__c,Marca__r.Name,Marca__c from modelo__c WHERE AnoFormula__c LIKE :ano
                ]);
                Set<Id> idSetMarcas = new  Set<Id>();
                for(Modelo__c modelo : modeloMap.values()){
                    idSetMarcas.add(modelo.Marca__c);
                }
                for(Marca__c marca : [SELECT Name FROM Marca__c WHERE Id IN :idSetMarcas]){
                    marcaMapByName.put(marca.Name,marca);
                }
                marcaList.addAll(marcaMapByName.values());
            }
            else if (flowInput.batch == 'getModeloByAnoAndMarca'){
                
                String ano = '%'+flowInput.anoSelecionado+'%';
                String marca = '%'+flowInput.marcaSelecionado+'%';

                Map<Id,Modelo__c> modeloMap =  NEW Map<Id,Modelo__c>([
                   select id,Name,AnoFormula__c,Marca__r.Name,Marca__c from modelo__c WHERE AnoFormula__c LIKE :ano AND  Marca__r.Name LIKE :marca
                ]);
                System.debug('modeloMap' +modeloMap);
                
                
                modeloList.addAll(modeloMap.values());
            }
        }
        
        FlowOutput output = new FlowOutput();
        output.anoValorList = anoValorList;
        output.marcaList = marcaList;
        System.debug('modeloList' +modeloList);
        output.modeloList = modeloList;
        return new List<FlowOutput>{output};
    }
    
    public class FlowInput{
        @InvocableVariable
        public String anoSelecionado;
        @InvocableVariable
        public String marcaSelecionado;
        @InvocableVariable
        public String modeloSelecionado;
        @InvocableVariable
        public String batch;
        @InvocableVariable
        public String recordId;
        public FlowInput(){
        }
        public FlowInput(String batch, Id recordId){
            this.batch = batch;
            this.recordId = recordId;
        }
    }
    
    public class FlowOutput{
         @InvocableVariable
        public List<Marca__c> marcaList;
        @InvocableVariable
        public List<AnoValor__c> anoValorList;
        @InvocableVariable
        public List<Modelo__c> modeloList;
       
        
        
        
    }
}