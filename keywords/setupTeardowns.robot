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

Create New User
    [Arguments]    ${active}=${True}    ${city}=TestCity    ${contractsCurrency}=USD   ${contractsId}=33  ${contractsPrice}=${9.99}
    ...   ${contractsType}=basic    ${email}=tom@miller.com
    ...  ${name}=miller    ${street}=1st street    ${surname}=tom    ${zip}=08100
    ...  ${numberOfContracts}=${1}  ${expectedStatusCode}=201
    @{contracts}  Create List
    IF  ${numberOfContracts} > ${0}
        FOR    ${counter}    IN RANGE    ${numberOfContracts}
            ${contract}    Create Dictionary  currency=${contractsCurrency}  id=${contractsId}
            ...  price=${contractsPrice}  type=${contractsType}
            Append To List    ${contracts}    ${contract}
        END
    END

    ${body}  Create Dictionary  active=${active}  city=${city}  contracts=${contracts}
    ...  email=${email}  name=${email}  street=${street}  surname=${surname}  zip=${zip}

    ${response}  POST  url=${GLOBAL_ENDPOINT_USERS}  json=${body}  expected_status=201  headers=${GLOBAL_AUTH_HEADERS}
    ${userId}    Set Variable  ${empty}
    IF  "${expectedStatusCode}" == "201"    # created
        ${userId}    Get From Dictionary    ${response.json()}    ID
    END
    [Return]    ${userId}    ${response}

Delete User
    [Arguments]  ${userId}
    ${response}  DELETE  url=${GLOBAL_ENDPOINT_USERS}/${userId}  expected_status=200  headers=${GLOBAL_AUTH_HEADERS}
    [Return]    ${response}
