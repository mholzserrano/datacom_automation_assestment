*** Keywords ****
Open Site
    [Documentation]                     This would open the browser and go to the site homepage.
    [Arguments]                         ${URL}
    Open Browser                        ${URL}
    ...                                 ${DATA_CONFIG['BROWSER']}
    Maximize Browser Window

Go to Payees Page
    [Documentation]                     This would navigate the website to the Payee page.
    Wait Until Element Is Visible       ${PAGE_CLIENT['BUTTON_MENU']}                           20s
    Click Button                        ${PAGE_CLIENT['BUTTON_MENU']}
    Wait Until Element Is Visible       ${COMPONENT_LEFTNAVBAR['PAYEES_MENU']}                  20s
    Click Element                       ${COMPONENT_LEFTNAVBAR['PAYEES_MENU']}
    Wait Until Element Is Visible       ${PAGE_PAYEES['HEADING_TITLE']}                         20s

Open Pay or Transfer Modal
    [Documentation]                     This would open the Pay or Transfer Modal
    Wait Until Element Is Visible       ${PAGE_CLIENT['BUTTON_MENU']}                           20s
    Click Button                        ${PAGE_CLIENT['BUTTON_MENU']}
    Wait Until Element Is Visible       ${COMPONENT_LEFTNAVBAR['PAY_TRANSFER_MENU']}            20s
    Click Button                        ${COMPONENT_LEFTNAVBAR['PAY_TRANSFER_MENU']}
    Wait Until Element Is Visible       ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_FROM_ACCOUNT']}  20s

Convert String to Number
    [Documentation]                     This would convert a String from the element text and convert it
    ...                                 to whole number. Return value can be use for computation.
    [Arguments]                         ${STRING}
    ${REMOVE_DECIMAL}                   Replace String          ${STRING}      
    ...                                 .00                     ${EMPTY}
    ${REMOVE_COMMA}                     Replace String          ${REMOVE_DECIMAL}
    ...                                 ,                       ${EMPTY}
    ${AMOUNT}                           Convert to Number       ${REMOVE_COMMA}
    [Return]                            ${AMOUNT}

Generate User Information
    [Documentation]     This would generate random user info.
    ${LAT}              Faker.Random Number
    ...                 digits=2
    ...                 fix_len=True
    ${LNG}              Faker.Random Number
    ...                 digits=2
    ...                 fix_len=True
    &{GEO}              Create Dictionary
    ...                 lat=${LAT}
    ...                 lng=${LNG}
    ${STREET}           Faker.Street Name
    ${SUITE}            Faker.Building Number
    ${CITY}             Faker.City
    ${ZIPCODE}          Faker.Zipcode
    &{ADDRESS}          Create Dictionary
    ...                 street=${STREET}
    ...                 suite=${SUITE}
    ...                 city=${CITY}
    ...                 zipcode=${ZIPCODE}
    ...                 geo=&{GEO}
    ${COMPANY_NAME}     Faker.Company
    ${CATCH_PRASE}      Faker.Catch Phrase
    ${BS}               Faker.Bs
    &{COMPANY}          Create Dictionary
    ...                 name=${COMPANY_NAME}
    ...                 catchPhrase=${CATCH_PRASE}
    ...                 bs=${BS}
    ${NAME}             Faker.Name
    ${USERNAME}         Faker.User Name
    ${EMAIL}            Faker.Email
    ${PHONE}            Faker.Phone Number
    ${WEBSITE}          Faker.Domain Name
    &{USER}             Create Dictionary
    ...                 name=${NAME}
    ...                 username=${USERNAME}
    ...                 email=${EMAIL}
    ...                 address=&{ADDRESS}
    ...                 phone=${PHONE}
    ...                 website=${WEBSITE}
    ...                 company=&{COMPANY}
    [Return]            &{USER}