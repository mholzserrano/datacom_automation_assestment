*** Settings ***
Library     BuiltIn
Library     SeleniumLibrary
Library     Collections
Library     RequestsLibrary
Library     String
Library     FakerLibrary        WITH NAME       FAKER

#CONFIG
Variables   ${EXECDIR}${/}DATA${/}data_config.py

#URLS
Variables   ${EXECDIR}${/}DATA${/}data_urls.py

#SPIELS
Variables   ${EXECDIR}${/}DATA${/}data_spiels.py

#INPUT
Variables   ${EXECDIR}${/}DATA${/}data_input.py

#LOCATORS PAGE
Variables   ${EXECDIR}${/}RESOURCES${/}LOCATORS${/}PAGES${/}page_client.py
Variables   ${EXECDIR}${/}RESOURCES${/}LOCATORS${/}PAGES${/}page_payees.py

#LOCATORS COMPONENT
Variables   ${EXECDIR}${/}RESOURCES${/}LOCATORS${/}COMPONENTS${/}component_leftnavbar.py
Variables   ${EXECDIR}${/}RESOURCES${/}LOCATORS${/}COMPONENTS${/}component_pay_transfer_modal.py

#KEYWORDS
Resource    ${EXECDIR}${/}RESOURCES${/}KEYWORDS${/}KEYWORD_COMMON.robot
Resource    ${EXECDIR}${/}RESOURCES${/}KEYWORDS${/}KEYWORD_PAYEES.robot
