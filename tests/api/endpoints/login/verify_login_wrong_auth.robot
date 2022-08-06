*** Settings ***
Resource    ../../../../testdata/variables/imports.resource

Library    RequestsLibrary
Library    ../../../../lib/json_validate_schema.py

*** Test Cases ***
Verify Login With Wrong Passwords Returns 401
    Log To Console    \nSending Requests To ${GLOBAL_ENDPOINT_LOGIN}\n 
    # Create a dictionary
    &{jsonBody}    Create Dictionary    username=admin    password=wrongPass 
    ${response}    POST    url=${GLOBAL_ENDPOINT_LOGIN}    json=${jsonBody}    expected_status=401
    Log To Console    ${response}
    Validate Json Schema    input_json=${response.json()}    reference_schema_path=${GLOBAL_SCHEMA_ERROR}