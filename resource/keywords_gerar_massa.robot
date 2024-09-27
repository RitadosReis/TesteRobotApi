** Settings ***
Resource        resource.robot

Library    XML

*** Keywords ***
Cadastrar empresa
#Massa para CEP
    ${ZIPCODE}                 Generate Random String      length=8     chars=[NUMBERS]
    Log         ${ZIPCODE}
    Set Global Variable        ${ZIPCODE}        ${ZIPCODE}   
    Log         ${ZIPCODE}
#Massa para cidade
    ${CITY}                    FakerLibrary.city
    Set Global Variable        ${CITY}
#Massa para estado
    ${STATE}                   FakerLibrary.State Abbr
    Set Global Variable        ${STATE}
#Massa para bairro
    ${DISTRICT}                Generate Random String      length=8      chars=[LETTERS]
    ${DISTRICT}                Convert To Lower Case        ${DISTRICT}
    Set Global Variable        ${DISTRICT}
#Massa para Rua/Contato do responsável/Descrição do serviço 
    ${NAME}             Generate Random String      length=8      chars=[LETTERS]
    ${LASTNAME}         Generate Random String      length=8      chars=[LETTERS]
    ${NAME}             Convert To Lower Case       ${NAME}
    ${FULLNAME}         Catenate                    Rua        R${NAME}       M${LASTNAME}
    Set Global Variable        ${FULLNAME}        
    Set Global Variable        ${NAME}
#Massa para Número
    ${NUMBER}                 Generate Random String      length=4     chars=[NUMBERS]
    Set Global Variable       ${NUMBER}  
 
#Massa para complemento
    ${COMPLEMENT}              Generate Random String      length=5      chars=[LETTERS]
    ${COMPLEMENT}              Convert To Lower Case       ${COMPLEMENT}
    Set Global Variable        ${COMPLEMENT}
#Massa para País 
    ${COUNTRY}               FakerLibrary.country
    Set Test Variable        ${COUNTRY}
#Massa para companhia/Matriz
    ${NAME}                    Generate Random String      length=8      chars=[LETTERS]
    ${LASTNAME}                Generate Random String      length=8      chars=[LETTERS]
    ${NAME}                    Convert To Lower Case       ${NAME}
    ${COMPANY}                 Catenate                    R${NAME}       M${LASTNAME} Comercio Ltda
    Set Global Variable        ${COMPANY}

#Massa para CNPJ
    ${CNPJFIRST}        Generate Random String      length=8     chars=[NUMBERS]
    ${CNPJLAST}         Generate Random String      length=2     chars=[NUMBERS]
    ${FULLCNPJ}         Catenate                    ${CNPJFIRST}0001${CNPJLAST}
    Set Global Variable                             ${FULLCNPJ}  

#Massa para email  
    ${MAIL}             Generate Random String      length=8      chars=[LETTERS]  
    ${MAIL}             Convert To Lower Case       ${MAIL}           
    ${DOMINIO}          Evaluate        random.choice(["@yahoo.com", "@gmail.com", "@outlook.com", "@hotmail.com.br", "@uol.com.br"])
    ${FULLMAIL}         Catenate        ${MAIL}${DOMINIO} 
    Set Global Variable                 ${FULLMAIL}  
    Set Global Variable                 ${MAIL}  
   
#Massa para Telefone 

    ${TELEPHONE}         Generate Random String      length=8     chars=[NUMBERS]
    ${TELEPHONE}          Catenate                   999999${TELEPHONE}
    Set Global Variable                              ${TELEPHONE}

#Massa para CNPJ 13 NUMERO
    ${CNPJFIRST}             Generate Random String      length=8     chars=[NUMBERS]
    ${CNPJLAST}              Generate Random String      length=2     chars=[NUMBERS]
    ${FULLCNPJMENOR}         Catenate                    ${CNPJFIRST}001${CNPJLAST}
    Set Global Variable                                  ${FULLCNPJMENOR} 

#Massa para CNPJ 15 NUMERO
    ${CNPJFIRST}             Generate Random String      length=8     chars=[NUMBERS]
    ${CNPJLAST}              Generate Random String      length=2     chars=[NUMBERS]
    ${FULLCNPJMAIOR}         Catenate                    ${CNPJFIRST}00001${CNPJLAST}
    Set Global Variable                                  ${FULLCNPJMAIOR}       

 #Massa para CNPJ com Letras
    ${CNPJFIRST}              Generate Random String      length=8     chars=[NUMBERS]
    ${CNPJLAST}               Generate Random String      length=2     chars=[NUMBERS]
    ${FULLCNPJLETRAS}         Catenate                    ${CNPJFIRST}0RM1${CNPJLAST}
    Set Global Variable                                   ${FULLCNPJLETRAS}    