*** Settings ***
Documentation     API tests for the public JSONPlaceholder REST API
...               (https://jsonplaceholder.typicode.com).
...               JSONPlaceholder fakes write operations (POST/PUT/DELETE answer as if they
...               worked but nothing is stored), so we only verify the responses.
Library           RequestsLibrary
Library           Collections
Library           ${CURDIR}/../../libraries/testdata.py
Suite Setup       Create Session    jsonplaceholder    ${BASE_URL}
Suite Teardown    Delete All Sessions
Test Tags         api


*** Variables ***
${BASE_URL}       https://jsonplaceholder.typicode.com


*** Test Cases ***
Get Single Post Returns Expected Fields
    [Documentation]    GET /posts/1 returns one post with the documented fields.
    [Tags]    smoke
    ${response}=    GET On Session    jsonplaceholder    /posts/1
    Status Should Be    200    ${response}
    ${post}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${post}[id]    1
    Dictionary Should Contain Key    ${post}    userId
    Dictionary Should Contain Key    ${post}    title
    Dictionary Should Contain Key    ${post}    body

Get All Posts Returns One Hundred Items
    [Documentation]    GET /posts returns the full list of 100 posts.
    ${response}=    GET On Session    jsonplaceholder    /posts
    Status Should Be    200    ${response}
    Length Should Be    ${response.json()}    100

Get Nonexistent Post Returns 404
    [Documentation]    Negative test: an unknown id must not return a post.
    ${response}=    GET On Session    jsonplaceholder    /posts/9999    expected_status=404
    Status Should Be    404    ${response}

Create Post Returns 201 And Echoes Data
    [Documentation]    POST /posts answers 201 with the data we sent plus a new id.
    ${payload}=    Build Post Payload    title=My test title
    ${response}=    POST On Session    jsonplaceholder    /posts    json=${payload}
    Status Should Be    201    ${response}
    Should Be Equal    ${response.json()}[title]    My test title
    Should Be Equal As Integers    ${response.json()}[id]    101
