*** Settings ***
Documentation     Data-driven login tests: the same check runs with different invalid inputs.
Resource          ${CURDIR}/../../resources/saucedemo.resource
Suite Setup       Start Browser Session
Suite Teardown    Close Browser
Test Setup        Open Login Page
Test Teardown     Close Context
Test Template     Login Should Fail With Message
Test Tags         ui    login    data-driven


*** Test Cases ***    USERNAME           PASSWORD          EXPECTED MESSAGE
Locked Out User       locked_out_user    secret_sauce      Sorry, this user has been locked out.
Wrong Password        standard_user      wrong_password    Username and password do not match any user in this service
Empty Password        standard_user      ${EMPTY}          Password is required
Unknown User          höpö       secret_sauce              Username and password do not match any user in this service
Empty username        ${EMPTY}           secret_sauce      Username is required


*** Keywords ***
Login Should Fail With Message
    [Documentation]    Try to log in and check that the expected error message is shown.
    [Arguments]    ${username}    ${password}    ${expected_message}
    Login As    ${username}    ${password}
    Login Error Should Be    ${expected_message}
