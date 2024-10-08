*** Settings ***
Documentation        
Resource             resource.robot       

*** Keywords ***
Realizar alteração status de true para false
    Cadastro empresa com sucesso
    
    ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}

    ${body}    Create Dictionary     status=false
    ${response_put_company}    PUT On Session    alias=chips    url=/company/status/${ID}    json=${body}     headers=${headers} 

    
    ${response_json}          Set Variable    ${response_put_company.json()}
    
    Status Should Be    201 
    Should Be Equal                   ${response_put_company.json()["msg"]}         Status da companhia atualizado com sucesso.
    Dictionary Should Contain Item    ${response_json['updateCompany']}             status        ${False}  