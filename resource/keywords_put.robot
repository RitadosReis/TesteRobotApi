*** Settings ***
Documentation        
Resource             resource.robot       

*** Keywords ***
Realizar alteração status de true para false
    Cadastro empresa com sucesso 
    
     ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}

    ${body}    Create Dictionary     status=false

        
    ${response_put_company}    PUT On Session    
    ...    alias=chips    
    ...    url=/company/status/${ID}
    ...    json=${body}  
    ...    headers=${headers} 
    

    
    Status Should Be    201 
    Dictionary Should Contain Item      ${response_put_company.json()["newCompany"]["_id"]}                
