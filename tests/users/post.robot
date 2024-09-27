*** Settings ***
Documentation        Validar login com sucesso   
Resource             ../../resource/resource.robot

*** Test Cases ***

Cadastrar usuario com sucesso 
    Login com sucesso
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    ...     Authorization=${TOKEN}

    ${CPF}          Generate Random String      length=11     chars=[NUMBERS]
    ${NAME}         Generate Random String      length=8      chars=[LETTERS]
    ${LASTNAME}     Generate Random String      length=8      chars=[LETTERS]
    ${FULLNAME}     Catenate                    R${NAME}       M${LASTNAME}
    ${MAIL}         Set Variable                teste${CPF}@qa-coders.com.br

       ${body}     Create Dictionary    
    ...    fullName=${FULLNAME}
    ...    mail=${MAIL}
    ...    accessProfile=ADMIN
    ...    cpf=${CPF}
    ...    password=12354@Test
    ...    confirmPassword=12354@Test

    ${response_post_user}     POST On Session    alias=chips     url=user/    json=${body}     headers=${headers}

    Status Should Be                    201
    Dictionary Should Contain Item      ${response_post_user.json()}                msg             Olá ${FULLNAME}, cadastro realizado com sucesso.
    Dictionary Should Contain Item      ${response_post_user.json()["user"]}        mail            ${MAIL} 
    Dictionary Should Contain Item      ${response_post_user.json()["user"]}        cpf             ${CPF} 
    Dictionary Should Contain Item      ${response_post_user.json()["user"]}        fullName        ${FULLNAME}
    Dictionary Should Contain Key       ${response_post_user.json()["user"]}        _id
    Set Test Variable                   ${ID}       ${response_post_user.json()["user"]["_id"]} 
    
    ${response_get_user}       GET On Session    alias=chips     url=user/${ID}        headers=${headers}
    Status Should Be           200
    Should Be Equal            ${response_get_user.json()["_id"]}       ${ID}  
    Should Be Equal            ${MAIL}      ${response_get_user.json()["mail"]}       
