*** Settings ***
Documentation        Arquivo das bibliotecas 
Library              RequestsLibrary
Library              Collections
Library              String
Library              FakerLibrary    locale=pt_BR    
Resource             keywords_gerar_massa.robot
Resource             keywords_post.robot
Resource             variables.resource    
Resource             login.robot


