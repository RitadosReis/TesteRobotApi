*** Settings ***
Documentation        Validar login com sucesso   
Resource             ../../resource/resource.robot

*** Test Cases ***
Login com sucesso 
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    
    Create Session      alias=chips     url=${URL}      headers=${headers}    verify=true   
     
    ${body}     Create Dictionary       mail=${USER}       password=${PASSWORD}

    ${response}     POST On Session    alias=chips     url=login    json=${body}

    Status Should Be                    200    
    Dictionary Should Contain Key       ${response.json()}      token 
    Set Suite Variable                  ${TOKEN}            ${response.json()["token"]}          

   