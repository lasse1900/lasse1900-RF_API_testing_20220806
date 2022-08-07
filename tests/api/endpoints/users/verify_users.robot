*** Settings ***
Resource    ../../../../testdata/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Authorize

*** Test Cases ***
Verify All Users 
    Log To Console    \nSending Request To ${GLOBAL_ENDPOINT_USERS}\n 
    ${params}    Create Dictionary    filter=all
    ${response}    GET    url=${GLOBAL_ENDPOINT_USERS}    expected_status=200
    ...    headers=${GLOBAL_AUTH_HEADERS}    params=${params}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS}