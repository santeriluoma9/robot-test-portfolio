*** Settings ***
Documentation     Cart tests for the Sauce Labs demo shop (https://www.saucedemo.com).
Resource          ${CURDIR}/../../resources/saucedemo.resource
Suite Setup       Start Browser Session
Suite Teardown    Close Browser
Test Setup        Open Login Page
Test Teardown     Close Context
Test Tags         ui    cart


*** Test Cases ***
Adding A Product Shows One Item In Cart
    [Documentation]    Adding one product updates the cart badge to 1.
    [Tags]    smoke
    Login As    standard_user
    Click    [data-test="add-to-cart-sauce-labs-backpack"]
    Get Text    [data-test="shopping-cart-badge"]    ==    1

Removing A Product Empties The Cart
    [Documentation]    Removing only product updates the cart badge to 1. 
    Login As    standard_user
    Click    [data-test="add-to-cart-sauce-labs-backpack"]
    Click    [data-test="remove-sauce-labs-backpack"]
    Get Element Count    [data-test="shopping-cart-badge"]    ==    0
