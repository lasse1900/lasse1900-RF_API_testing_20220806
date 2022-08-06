*** Settings ***
Resource    ../../../../testdata/variables/imports.resource

Library    RequestsLibrary
Library    ../../../../lib/json_validate_schema.py

Test Template    Custom Test Template

*** Test Cases ***                                USERNAME     PASSWORD
Verify Login With Wrong Passwords Returns 401     admin        wrongPass      

Verify Login With Wrong User Returns 401          quest        masterPass 

Verify Login With Wrong User Returns 401          ${EMPTY}     ${EMPTY} 

Verify Login With Wrong User And Password Returns 401          quest        wrongPass 

*** Keywords ***
Custom Test Template
    # Create a dictionary
    [Arguments]    ${username}    ${password}
    &{jsonBody}    Create Dictionary    username=${username}    password=${password}
    ${response}    POST    url=${GLOBAL_ENDPOINT_LOGIN}    json=${jsonBody}    expected_status=401
    Log To Console    ${response}
    Validate Json Schema    input_json=${response.json()}    reference_schema_path=${GLOBAL_SCHEMA_ERROR}
