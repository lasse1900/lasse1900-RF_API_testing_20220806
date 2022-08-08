*** Settings ***
Resource    ../../../testdata/variables/imports.resource
Resource    ../../../keywords/imports.resource
Resource    ../../../keywords/setupTeardowns.robot

*** Variables ***
${SUITE_WRONG_TOKEN_HEADER}  Authorization=Bearer i-am-no-toke
${SUITE_EMPTY_TOKEN_HEADER}    Authorization=${empty}

*** Test Cases ***                ENDPOINT                    AUTH HEADER
Verify Get Users Wrong Token      ${GLOBAL_ENDPOINT_USERS}    ${SUITE_WRONG_TOKEN_HEADER}  
    [Template]  Custom Test Template Get
Verify Get Users Empty Token      ${GLOBAL_ENDPOINT_USERS}   ${SUITE_EMPTY_TOKEN_HEADER}  
    [Template]  Custom Test Template Get

Verify Get Users Id Wrong Token      ${GLOBAL_ENDPOINT_USERS}/1    ${SUITE_WRONG_TOKEN_HEADER}  
    [Template]  Custom Test Template Get
Verify Get Users Id Empty Token      ${GLOBAL_ENDPOINT_USERS}/1   ${SUITE_EMPTY_TOKEN_HEADER}  
    [Template]  Custom Test Template Get

Verify Post Users Wrong Token      ${GLOBAL_ENDPOINT_USERS}    ${SUITE_WRONG_TOKEN_HEADER}  
    [Template]  Custom Test Template Post
Verify Post Users Empty Token      ${GLOBAL_ENDPOINT_USERS}   ${SUITE_EMPTY_TOKEN_HEADER}  
    [Template]  Custom Test Template Post

Verify DELETE Users Wrong Token      ${GLOBAL_ENDPOINT_USERS}/1    ${SUITE_WRONG_TOKEN_HEADER}  
    [Template]  Custom Test Template Delete
Verify DELETE Users Empty Token      ${GLOBAL_ENDPOINT_USERS}/1   ${SUITE_EMPTY_TOKEN_HEADER}  
    [Template]  Custom Test Template Delete

*** Keywords ***
Custom Test Template Get
    [Arguments]    ${endpoint}    ${authHeader}
    ${response}  GET  url=${endpoint}  expected_status=401  headers=${authHeader}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}

Custom Test Template Post
    [Arguments]    ${endpoint}    ${authHeader}
    ${response}  POST  url=${endpoint}  expected_status=401  headers=${authHeader}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}

Custom Test Template Delete
    [Arguments]    ${endpoint}    ${authHeader}
    ${response}  DELETE  url=${endpoint}  expected_status=401  headers=${authHeader}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_ERROR}