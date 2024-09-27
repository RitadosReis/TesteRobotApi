*** Settings ***
Resource        ../../resource/resource.robot  
Resource    ../../resource/keywords_put.robot
Test Setup      Login com sucesso

*** Test Cases ***
Funcional - Atualizar o status da empresa
    Realizar alteração status de true para false
    
#Funcional - listar company
#     Realizar login
#     Listagem company 

# #Funcional - Contar company
#     Realizar login
#     Count company

# #Funcional - Pegar company
#     Realizar login
#     Get company 