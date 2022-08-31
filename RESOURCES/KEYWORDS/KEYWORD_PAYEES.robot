*** Keywords ***
Generate Payees Info
    [Documentation]                     This would generate random Payee and Account Number info.
    ${NAME}                             Faker.Last Name
    ${BANK}                             Faker.Random Number
    ...                                 digits=2
    ...                                 fix_len=True
    ${BRANCH}                           Faker.Random Number
    ...                                 digits=4
    ...                                 fix_len=True
    ${ACCOUNT}                          Faker.Random Number
    ...                                 digits=7
    ...                                 fix_len=True
    ${SUFFIX}                           Faker.Random Number
    ...                                 digits=1
    ...                                 fix_len=True
    &{PAYEE}                            Create Dictionary
    ...                                 NAME=${NAME}
    ...                                 BANK=${BANK}
    ...                                 BRANCH=${BRANCH}
    ...                                 ACCOUNT=${ACCOUNT}
    ...                                 SUFFIX=000${SUFFIX}
    [Return]                            &{PAYEE}


Open the Add Payee Modal
    [Documentation]                     This would open the Add Payee Modal
    Wait Until Element Is Visible       ${PAGE_PAYEES['BUTTON_ADD']}    20s
    Click Button                        ${PAGE_PAYEES['BUTTON_ADD']}
    Wait Until Element Is Visible       ${PAGE_PAYEES['FORM_PAYEE']}    20s


Filled Up Payee Form
    [Documentation]                     This would filled up the Payee Form
    &{PAYEE}                            Generate Payees Info
    Wait Until Element Is Visible       ${PAGE_PAYEES['INPUT_NAME']}            20s
    Input Text                          ${PAGE_PAYEES['INPUT_NAME']}
    ...                                 ${PAYEE['NAME']}
    Wait Until element Is Visible       ${PAGE_PAYEES['DROPDOWN_PAYEE_NAME']}   20s
    Click Element                       ${PAGE_PAYEES['BUTTON_SOMEONE_NEW']}
    Input Text                          ${PAGE_PAYEES['INPUT_BANK']}
    ...                                 ${PAYEE['BANK']}
    Input Text                          ${PAGE_PAYEES['INPUT_BRANCH']}
    ...                                 ${PAYEE['BRANCH']}
    Input Text                          ${PAGE_PAYEES['INPUT_ACCOUNT']}
    ...                                 ${PAYEE['ACCOUNT']}
    Input Text                          ${PAGE_PAYEES['INPUT_SUFFIX']}
    ...                                 ${PAYEE['SUFFIX']}
    Click Button                        ${PAGE_PAYEES['BUTTON_ADD_PAYEE']}
    Wait Until Element Is Visible       ${PAGE_PAYEES['ALERT_NOTIFCATION']}     20s
    [Return]                            &{PAYEE}

Get Payee Name List from Payee Table
    [Documentation]                     This would get all the text of the same or match locators
    ...                                 and put it on a list
    @{PAYEE_NAMES}                      Get WebElements     ${PAGE_PAYEES['ITEM_PAYEE_NAME']}
    ${PAYEE_NAMES_LIST}                 Create List
    FOR     ${PAYEE_NAME}   IN      @{PAYEE_NAMES}
        ${TEXT}     Get Text        ${PAYEE_NAME}
        Append To List      ${PAYEE_NAMES_LIST}     ${TEXT}
    END
    [Return]                            @{PAYEE_NAMES_LIST}
