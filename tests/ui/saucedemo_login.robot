*** Settings ***
Documentation     Login tests for the Sauce Labs demo shop (https://www.saucedemo.com).
Resource          ${CURDIR}/../../resources/saucedemo.resource
Suite Setup       Start Browser Session
Suite Teardown    Close Browser
Test Setup        Open Login Page
Test Teardown     Close Context
Test Tags         ui    login


*** Test Cases ***
Standard User Can Log In
    [Documentation]    A valid user lands on the product listing.
    [Tags]    smoke
    Login As    standard_user
    Inventory Page Should Be Open

Locked Out User Sees Error Message
    [Documentation]    A locked out user is not let in and sees an explanation.
    Login As    locked_out_user
    Login Error Should Be    Sorry, this user has been locked out.

Wrong Password Is Rejected
    [Documentation]    A valid username with a wrong password must not log in.
    Login As    standard_user    wrong_password
    Login Error Should Be    Username and password do not match any user in this service

Empty Password Is Rejected
    [Documentation]    A missing password gives a clear validation message.
    Login As    standard_user    ${EMPTY}
    Login Error Should Be    Password is required
