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

