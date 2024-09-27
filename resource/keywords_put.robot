*** Settings ***
Documentation        
Resource             resource.robot       

*** Keywords ***
Realizar alteração status de true para false
    Login com sucesso
    
     ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}

    ${body}    Create Dictionary     status=false
    PUT On Session    alias=chips    url=/company/${_id}    json=${body}        
    
    ${response_put_company}    PUT On Session    
    ...    alias=chips    
    ...    url=company/
    ...    json=${body}  
    ...    headers=${headers} 
    
    Status Should Be    201 
    Dictionary Should Contain Item      ${response_put_company.json()["newCompany"]}                 mail                      ${MAIL}
  