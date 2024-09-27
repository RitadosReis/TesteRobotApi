*** Settings ***
Resource        ../../resource/resource.robot  
Test Setup      Login com sucesso

*** Test Cases ***
CT01 - Cadastrar empresa com sucesso 
    Cadastro empresa com sucesso 
          
    
CT02 - Não Funcional - cadastro com cnpj já existente
    Cadastrar empresa        
    Verificar se a API não permitiu o cadastro com um cnpj já existente 
    
CT03 - Não Funcional - CNPJ com 13 números
   Cadastrar empresa      
   Verificar se a API não permitiu o cadastro com cnpj com 13 números

CT04 - Não Funcional - CNPJ com 15 números
    Cadastrar empresa   
    Verificar se a API não permitiu o cadastro com cnpj com 15 números

CT05 - Não Funcional - CNPJ com letras
    Cadastrar empresa 
    Verificar se a API não permitiu o cadastro com cnpj com letras    

# #Criar uma empresa com token inválido
#     #Realizar login com token inválido
#     #Novo cadastro com token inválido       

# Funcional - Atualizar o status da empresa
#     Realizar alteração status de true para false
    
# listar company
#     Realizar login
#     Listagem company 

# Contar company
#     Realizar login
#     Count company

# Pegar company
#     Realizar login
#     Get company 

# Get company ID inválido
#     Realizar login
#     Get company 

