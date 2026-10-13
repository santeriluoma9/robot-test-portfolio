*** Settings ***
Documentation     Shared variables and keywords for the SauceDemo UI tests.
...               Selectors and page-specific logic live here, so the test files read
...               like plain English and only one place needs fixing if the UI changes.
Library           Browser


*** Variables ***
${BASE_URL}              https://www.saucedemo.com
${DEFAULT_PASSWORD}      secret_sauce
${HEADLESS}              ${True}

# Selectors (find new ones with the browser developer tools: F12)
${USERNAME_FIELD}        [data-test="username"]
${PASSWORD_FIELD}        [data-test="password"]
${LOGIN_BUTTON}          [data-test="login-button"]
${ERROR_MESSAGE}         [data-test="error"]
${PAGE_TITLE}            [data-test="title"]


*** Keywords ***
Start Browser Session
    [Documentation]    Launch one browser for the whole suite.
    ...                Run with  -v HEADLESS:False  to watch the browser while it works.
    New Browser    chromium    headless=${HEADLESS}

Open Login Page
    [Documentation]    Fresh browser context (clean cookies and storage) and the login page.
    New Context
    New Page    ${BASE_URL}

Login As
    [Documentation]    Fill in the login form and submit it.
    [Arguments]    ${username}    ${password}=${DEFAULT_PASSWORD}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click        ${LOGIN_BUTTON}

Inventory Page Should Be Open
    [Documentation]    After a successful login the product listing is shown.
    Get Url     contains    /inventory.html
    Get Text    ${PAGE_TITLE}    ==    Products

Login Error Should Be
    [Documentation]    The error banner contains the expected message.
    [Arguments]    ${expected_message}
    Get Text    ${ERROR_MESSAGE}    contains    ${expected_message}
