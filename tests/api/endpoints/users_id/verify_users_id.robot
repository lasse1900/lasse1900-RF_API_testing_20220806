*** Settings ***
Resource    ../../../../testdata/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Authorize

*** Test Cases ***
Verify Exixting User
    Log To Console    \nSending Request To    ${GLOBAL_ENDPOINT_USERS}/1\n
    ${response}    Get    url=${GLOBAL_ENDPOINT_USERS}/1    expected_status=200    headers=${GLOBAL_AUTH_HEADERS}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS_ID}