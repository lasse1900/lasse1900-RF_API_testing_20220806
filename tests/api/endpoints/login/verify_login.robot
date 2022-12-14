*** Settings ***
Resource    ../../../../testdata/variables/imports.resource

Library    RequestsLibrary
Library    ../../../../lib/json_validate_schema.py

*** Test Cases ***
Verify Login Returns 200
    ${response}    Get    url=${GLOBAL_ENDPOINT_USERS}/1    expected_status=200    headers=${GLOBAL_AUTH_HEADERS}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS_ID}