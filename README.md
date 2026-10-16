# Test Automation Portfolio

[![Robot Framework tests](https://github.com/santeriluoma9/robot-test-portfolio/actions/workflows/robot-tests.yml/badge.svg)](https://github.com/santeriluoma9/robot-test-portfolio/actions/workflows/robot-tests.yml)

A hands-on test automation project built with **Robot Framework**, **Python** and **GitHub Actions**.

I come from B2B sales and built this project to move into software testing. My goal was to learn
the full loop of test automation in practice: designing test cases, writing and running them,
investigating failures and running everything automatically in a CI pipeline.

## What is tested

| Area | Target | What the tests cover |
|------|--------|----------------------|
| UI | [Sauce Labs demo shop](https://www.saucedemo.com) | Successful login, five invalid login cases (data-driven), adding and removing a product in the cart |
| API | [JSONPlaceholder](https://jsonplaceholder.typicode.com) fake REST API | Fetching single and all posts, a non-existent post (404), creating a post, filtering posts by user, fetching comments for a post |

14 tests in total. UI tests use the [Browser library](https://github.com/MarketSquare/robotframework-browser) (Playwright)
and API tests use [RequestsLibrary](https://github.com/MarketSquare/robotframework-requests).

## Project structure

```
.github/workflows/   CI pipeline that runs all tests on every push
libraries/           custom Python keyword library (test data generation)
resources/           shared keywords and selectors for the UI tests
scripts/             Bash helper for running the tests
tests/api/           API test suites
tests/ui/            UI test suites
```

## Getting started

Prerequisites: Python 3.10 or newer, Node.js 20 or newer (required by the Browser library) and Git.

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
sudo npx --yes playwright install-deps chromium
rfbrowser init chromium
```

## Running the tests

```bash
robot --outputdir results tests/                  # everything
robot --outputdir results --include smoke tests/  # only tests tagged "smoke"
robot --outputdir results tests/api               # only the API tests
```

Open `results/report.html` for the summary and `results/log.html` for step-by-step details.

## Continuous integration

`.github/workflows/robot-tests.yml` installs the dependencies, runs all tests on every push and
uploads the Robot Framework report as a build artifact (Actions tab → a run → Artifacts).

## Test design notes

- **Positive and negative cases.** Login is tested both with a valid user and with invalid input
  (locked out user, wrong password, unknown user, empty username, empty password).
- **Data-driven login tests.** The invalid login cases share the same steps and differ only in
  their input and expected error message, so they are written as one template keyword and a table
  of test data. Adding a new case is one new row.
- **Independent tests.** Every UI test starts in a fresh browser context, so tests do not depend on
  each other and can run in any order.
- **Stable selectors.** UI tests use `data-test` attributes instead of CSS classes or visible texts,
  which change more often.
- **Checking every item, not just the count.** API filtering tests loop through every returned item
  and check that it belongs to the requested user or post. Checking the count alone would miss
  wrong items in the response.
- **Checking that an element is gone.** When the cart is empty, the cart badge does not exist at all,
  so the test checks the number of badge elements (0) instead of reading its text.
- **Making sure the tests can fail.** I deliberately broke a test and checked that it failed with a
  clear message, to confirm that it really verifies something.

## What I learned

- Reading Robot Framework logs to find out why a test failed
- How Robot Framework parses files: section headers, indentation and separators between arguments
- Finding element selectors with the browser developer tools
- Working with Git and keeping a CI pipeline green

## Next steps

- [ ] Checkout flow UI tests
- [ ] More API tests (PUT, PATCH, DELETE)
- [ ] Pin dependency versions
