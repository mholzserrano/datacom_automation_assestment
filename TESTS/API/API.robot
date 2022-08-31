*** Settings ***
Resource        ${EXECDIR}${/}RESOURCES${/}COMMON.robot

*** Test Cases ***
Verify GET Users request
    ${RESPONSE}         GET
    ...                 ${DATA_CONFIG['BASE_URL']}${DATA_CONFIG['USER_PATH']}
    Status Should Be    200
    ...                 ${RESPONSE}
    ${RESPONSE_LENGTH}  Get Length
    ...                 ${RESPONSE.json()}
    Should Be Equal     ${RESPONSE_LENGTH}
    ...                 ${DATA_INPUT['LENGTH']}

Verify GET User request by Id
    ${RESPONSE}         GET
    ...                 ${DATA_CONFIG['BASE_URL']}${DATA_CONFIG['USER_PATH']}${DATA_INPUT['USER_ID']}
    Status Should Be    200
    Should Be Equal     ${RESPONSE.json()['name']}
    ...                 ${DATA_INPUT['EXPECTED_NAME']}

Verify POST Users request 
    &{USER}             Generate User Information
    ${RESPONSE}         POST
    ...                 ${DATA_CONFIG['BASE_URL']}${DATA_CONFIG['USER_PATH']}
    ...                 json=${USER}
    Status Should Be    201
    Should Be Equal     ${USER['name']}         ${RESPONSE.json()['name']}
    Should Be Equal     ${USER['username']}     ${RESPONSE.json()['username']}
    Should Be Equal     ${USER['email']}        ${RESPONSE.json()['email']}
    Should Be Equal     ${USER['address']}      ${RESPONSE.json()['address']}
    Should Be Equal     ${USER['phone']}        ${RESPONSE.json()['phone']}
    Should Be Equal     ${USER['website']}      ${RESPONSE.json()['website']}
    Should Be Equal     ${USER['company']}      ${RESPONSE.json()['company']}
    Should Contain      ${RESPONSE.json()}      id