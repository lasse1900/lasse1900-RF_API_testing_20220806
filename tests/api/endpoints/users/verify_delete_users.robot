*** Settings ***
Resource    ../../../../testdata/variables/imports.resource
Resource    ../../../../keywords/imports.resource
Resource    ../../../../keywords/setupTeardowns.robot

Suite Setup    Custom Suite Setup

*** Variables ***
${SUITE_USER_ID}  ${empty}

*** Test Cases ***
Verify Delete Users
    ${response}  Delete User    ${SUITE_USER_ID}
    Validate Schema    inputJson=${response.json()}    referenceSchemaPath=${GLOBAL_SCHEMA_USERS_DELETE}

*** Keywords ***
Custom Suite Setup
    Authorize
    ${id}    ${response}    Create New User 
    Set Suite Variable  ${SUITE_USER_ID}    ${id}