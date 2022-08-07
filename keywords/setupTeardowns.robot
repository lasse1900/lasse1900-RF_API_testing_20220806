*** Settings ***
Resource    ../testdata/variables/imports.resource
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Authorize
    IF  not ${GLOBAL_AUTH_SET}
        &{jsonBody}    Create Dictionary    username=admin    password=masterPass 
        ${response}    POST    url=${GLOBAL_ENDPOINT_LOGIN}    json=${jsonBody}    expected_status=200
        ${responseJson}    Set Variable    ${response.json()}
        ${token}    Get From Dictionary    ${responseJson}    token
        ${headers}    Create Dictionary    Authorization=Bearer ${token}
        Set Global Variable    ${GLOBAL_AUTH_HEADERS}    ${headers}
        Set Global Variable    ${GLOBAL_AUTH_SET}    ${True}
    END