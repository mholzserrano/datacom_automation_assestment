*** Settings ***
Resource        ${EXECDIR}${/}RESOURCES${/}COMMON.robot

Test Setup      Open Site
...             ${DATA_URLS['URL_CLIENT']}
Test Teardown   Close Browser

*** Test Cases ***

Verify you can navigate to Payees page using the navigation menu
    Go to Payees Page
    Element Text Should Be              ${PAGE_PAYEES['HEADING_TITLE']}
    ...                                 Payees

Verify you can add new payee in the Payees page
    Go to Payees Page
    Open the Add Payee Modal
    &{PAYEE}                            Filled Up Payee Form
    Element Text Should Be              ${PAGE_PAYEES['ALERT_NOTIFCATION']}
    ...                                 ${DATA_SPIELS['PAYEE_ADD_SUCCESS']}
    Wait Until Element Is Not Visible   ${PAGE_PAYEES['FORM_PAYEE']}    20s
    Page Should Contain                 ${PAYEE['NAME']}

Verify payee name is a required field
    Go to Payees Page
    Open the Add Payee Modal
    Click Element                       ${PAGE_PAYEES['INPUT_NAME']}
    Click Element                       ${PAGE_PAYEES['BUTTON_ADD_PAYEE']}
    Wait Until Element Is Visible       ${PAGE_PAYEES['ALERT_ERROR']}   20s
    Element Text Should Be              ${PAGE_PAYEES['ALERT_ERROR']}
    ...                                 ${DATA_SPIELS['PAYEE_REQUIRED_ERROR']}
    Filled Up Payee Form                
    Page Should Not Contain Element     ${PAGE_PAYEES['ALERT_ERROR']}

Verify that payees can be sorted by name
    Go to Payees Page
    Wait Until Element Is Visible       ${PAGE_PAYEES['ITEM_PAYEE_NAME']}   20s
    ${PAYEE_NAMES_LIST}                 Get Payee Name List from Payee Table
    @{SORTED_PAYEES_NAMES_LIST}         Copy List       ${PAYEE_NAMES_LIST}
    Sort List                           ${SORTED_PAYEES_NAMES_LIST}
    Lists Should Be Equal               ${SORTED_PAYEES_NAMES_LIST}     ${PAYEE_NAMES_LIST}
    Wait Until Element Is Visible       ${PAGE_PAYEES['BUTTON_NAME']}       20s
    Click Element                       ${PAGE_PAYEES['BUTTON_NAME']}
    Wait Until Element Is Visible       ${PAGE_PAYEES['DESC_INDICATOR']}    20s
    ${PAYEE_NAMES_LIST}                 Get Payee Name List from Payee Table
    Reverse List                        ${SORTED_PAYEES_NAMES_LIST}
    Lists Should Be Equal               ${SORTED_PAYEES_NAMES_LIST}     ${PAYEE_NAMES_LIST}


Navigate to Payments page
    Wait Until Element Is Visible       ${PAGE_CLIENT['BUTTON_MENU']}                           20s
    ${BEFORE_STRING_EVERYDAY} =         Get Text        ${PAGE_CLIENT['AMOUNT_EVERYDAY']}
    ${BEFORE_STRING_BILLS} =            Get Text        ${PAGE_CLIENT['AMOUNT_BILLS']}
    ${BEFORE_AMOUNT_EVERYDAY} =         Convert String to Number     ${BEFORE_STRING_EVERYDAY}
    ${BEFORE_AMOUNT_BILLS} =            Convert String to Number     ${BEFORE_STRING_BILLS}
    ${EXPECTED_AMOUNT_EVERYDAY} =       Evaluate        ${BEFORE_AMOUNT_EVERYDAY} - ${DATA_INPUT['AMOUNT']}
    ${EXPECTED_AMOUNT_BILLS} =          Evaluate        ${BEFORE_AMOUNT_BILLS} + ${DATA_INPUT['AMOUNT']}
    Open Pay or Transfer Modal
    Click Button                        ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_FROM_ACCOUNT']}
    Wait Until Element Is Enabled       ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_EVERYDAY']}      20s
    Sleep                               2s
    CLick Button                        ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_EVERYDAY']}
    Wait Until Element Is Visible       ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_TO_ACCOUNT']}    20s
    Click Button                        ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_TO_ACCOUNT']}
    Wait Until Element Is Visible       ${COMPONENT_PAY_TRANSFER_MODAL['TAB_ACCOUNT']}          20s
    Click Element                       ${COMPONENT_PAY_TRANSFER_MODAL['TAB_ACCOUNT']}
    Wait Until Element Is Enabled       ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_BILLS']}         20s
    Sleep                               2s
    Click Button                        ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_BILLS']}
    Wait Until Element Is Visible       ${COMPONENT_PAY_TRANSFER_MODAL['INPUT_AMOUNT']}         20s
    Input Text                          ${COMPONENT_PAY_TRANSFER_MODAL['INPUT_AMOUNT']}
    ...                                 ${DATA_INPUT['AMOUNT']}
    Wait Until Element Is Visible       ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_TRANSFER']}      20s
    Click Button                        ${COMPONENT_PAY_TRANSFER_MODAL['BUTTON_TRANSFER']}
    Wait Until Element Is Visible       ${PAGE_PAYEES['ALERT_NOTIFCATION']}                     20s
    Element Text Should Be              ${PAGE_PAYEES['ALERT_NOTIFCATION']}
    ...                                 ${DATA_SPIELS['TRANSFER_SUCCESS']}
    ${AFTER_STRING_EVERYDAY} =          Get Text                    ${PAGE_CLIENT['AMOUNT_EVERYDAY']}
    ${AFTER_AMOUNT_EVERYDAY}            Convert String to Number    ${AFTER_STRING_EVERYDAY}
    ${AFTER_STRING_BILLS} =             Get Text                    ${PAGE_CLIENT['AMOUNT_BILLS']}
    ${AFTER_AMOUNT_BILLS}               Convert String to Number    ${AFTER_STRING_BILLS}
    Should Be Equal                     ${AFTER_AMOUNT_EVERYDAY}    ${EXPECTED_AMOUNT_EVERYDAY}
    Should Be Equal                     ${AFTER_AMOUNT_BILLS}       ${EXPECTED_AMOUNT_BILLS}
