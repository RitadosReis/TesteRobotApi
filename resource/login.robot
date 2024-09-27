** Settings ***
Resource        variables.resource
Resource        resource.robot


*** Keywords ***
Login com sucesso 
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    
    Create Session      alias=chips     url=${URL}      headers=${headers}    verify=true   
     
    ${body}     Create Dictionary       mail=${USER}       password=${PASSWORD}

    ${response}     POST On Session    alias=chips     url=login    json=${body}

    Set Suite Variable                  ${TOKEN}            ${response.json()["token"]}    