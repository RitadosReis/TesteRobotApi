*** Settings ***
Documentation        
Resource             resource.robot       

*** Keywords ***
Criar sessão    
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session      alias=chips     url=${URL}      headers=${headers}    verify=true 
    
Cadastro empresa com sucesso 
    Login com sucesso
    Cadastrar empresa
    ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}
    
    ${endereco}    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${NAME}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
   
    ${endereco_list}           Create List    ${endereco}
    Set Global Variable        ${endereco_list}
   
    ${body}     Create Dictionary    
    ...    corporateName=${COMPANY}       
    ...    registerCompany=${FULLCNPJ}
    ...    mail=${FULLMAIL}
    ...    matriz=${FULLNAME}
    ...    responsibleContact=${NAME}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${NAME}
    ...    address=${endereco_list}
    #Log    ${body}
    ${response_post_company}    POST On Session    
    ...    alias=chips    
    ...    url=company/
    ...    json=${body}  
    ...    headers=${headers}
      
    Status Should Be                        201    
    Dictionary Should Contain Item        ${response_post_company.json()}                                   msg                        Olá a companhia ${COMPANY} foi cadastrada com sucesso.
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     corporateName              ${COMPANY} 
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     registerCompany            ${FULLCNPJ}
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     mail                       ${FULLMAIL}
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     matriz                     ${FULLNAME}    
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     responsibleContact         ${NAME}
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     telephone                  ${TELEPHONE}
    Dictionary Should Contain Item        ${response_post_company.json()["newCompany"]}                     serviceDescription         ${NAME}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         zipCode                    ${ZIPCODE}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         city                       ${CITY}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         state                      ${STATE}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         district                   ${DISTRICT} 
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         street                     ${NAME}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         number                     ${NUMBER}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         complement                 ${COMPLEMENT}
    Dictionary Should Contain Item      ${response_post_company.json()["newCompany"]["address"][0]}         country                    ${COUNTRY}
    Dictionary Should Contain Key       ${response_post_company.json()["newCompany"]}        _id
    Set Test Variable                   ${ID}       ${response_post_company.json()["newCompany"]["_id"]} 
    
    ${response_get_company}       GET On Session    alias=chips     url=company/${ID}        headers=${headers}
    Status Should Be           200
    Should Be Equal            ${response_get_company.json()["_id"]}       ${ID}  
    
    Should Be Equal            ${FULLCNPJ}      ${response_get_company.json()["registerCompany"]} 


Verificar se a API não permitiu o cadastro com um cnpj já existente        
    Login com sucesso
    Cadastrar empresa
    ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}
    
    ${endereco}    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${NAME}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
   
    ${endereco_list}           Create List    ${endereco}
    Set Global Variable        ${endereco_list}
   
    ${body}     Create Dictionary    
    ...    corporateName=${COMPANY}       
    ...    registerCompany=06912478000196
    ...    mail=${MAIL}@gmail.com
    ...    matriz=${FULLMAIL}  
    ...    responsibleContact=${NAME}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${NAME}
    ...    address=${endereco_list}
    Log    ${body}
    ${response_post_company}    POST On Session    
    ...    alias=chips    
    ...    url=company/
    ...    json=${body}  
    ...    headers=${headers}
    ...    expected_status=400


    Status Should Be    400             ${response_post_company} 
    Should Be Equal                     ${response_post_company.json()["alert"][0]}                               Essa companhia já está cadastrada. Verifique o nome, CNPJ e a razão social da companhia.

Verificar se a API não permitiu o cadastro com cnpj com 13 números    
    Login com sucesso
    Cadastrar empresa
    ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}
    
    ${endereco}    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${NAME}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
   
    ${endereco_list}           Create List    ${endereco}
    Set Global Variable        ${endereco_list}
   
    ${body}     Create Dictionary    
    ...    corporateName=${COMPANY}       
    ...    registerCompany=${FULLCNPJMENOR}
    ...    mail=${MAIL}@gmail.com
    ...    matriz=${FULLMAIL}  
    ...    responsibleContact=${NAME}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${NAME}
    ...    address=${endereco_list}
    Log    ${body}
    ${response_post_company}    POST On Session    
    ...    alias=chips    
    ...    url=company/
    ...    json=${body}  
    ...    headers=${headers}
    ...    expected_status=400
    
    Status Should Be    400             ${response_post_company} 
    Should Be Equal                   ${response_post_company.json()["error"][0]}                               O campo 'CNPJ' da empresa deve ter no máximo 14 caracteres numéricos.

Verificar se a API não permitiu o cadastro com cnpj com 15 números
    Login com sucesso
    Cadastrar empresa
    ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}
    
    ${endereco}    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${NAME}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
   
    ${endereco_list}           Create List    ${endereco}
    Set Global Variable        ${endereco_list}
   
    ${body}     Create Dictionary    
    ...    corporateName=${COMPANY}       
    ...    registerCompany=${FULLCNPJMAIOR}
    ...    mail=${MAIL}@gmail.com
    ...    matriz=${FULLMAIL}  
    ...    responsibleContact=${NAME}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${NAME}
    ...    address=${endereco_list}
    Log    ${body}
    ${response_post_company}    POST On Session    
    ...    alias=chips    
    ...    url=company/
    ...    json=${body}  
    ...    headers=${headers}
    ...    expected_status=400
   

    Status Should Be    400             ${response_post_company} 
    Should Be Equal                   ${response_post_company.json()["error"][0]}                               O campo 'CNPJ' da empresa deve ter no máximo 14 caracteres numéricos. 

Verificar se a API não permitiu o cadastro com cnpj com letras 
    Login com sucesso
    Cadastrar empresa
    ${headers}     Create Dictionary    accept=application/json    Content-Type=application/json
    ...    Authorization=${TOKEN}
    
    ${endereco}    Create Dictionary
    ...    zipCode=${ZIPCODE}
    ...    city=${CITY}
    ...    state=${STATE}
    ...    district=${DISTRICT}
    ...    street=${NAME}
    ...    number=${NUMBER}
    ...    complement=${COMPLEMENT}
    ...    country=${COUNTRY}
   
    ${endereco_list}           Create List    ${endereco}
    Set Global Variable        ${endereco_list}
   
    ${body}     Create Dictionary    
    ...    corporateName=${COMPANY}       
    ...    registerCompany=${FULLCNPJLETRAS} 
    ...    mail=${MAIL}@gmail.com
    ...    matriz=${FULLMAIL}  
    ...    responsibleContact=${NAME}
    ...    telephone=${TELEPHONE}
    ...    serviceDescription=${NAME}
    ...    address=${endereco_list}
    Log    ${body}
    ${response_post_company}    POST On Session    
    ...    alias=chips    
    ...    url=company/
    ...    json=${body}  
    ...    headers=${headers}
    ...    expected_status=400
  
    Status Should Be    400             ${response_post_company} 
    Should Be Equal                     ${response_post_company.json()["error"][0]}       O campo 'CNPJ' da empresa deve conter apenas números.