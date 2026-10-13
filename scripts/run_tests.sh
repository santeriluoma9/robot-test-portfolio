#!/usr/bin/env bash
# Run the Robot Framework test suites.
#
# Usage:
#   ./scripts/run_tests.sh            run everything
#   ./scripts/run_tests.sh smoke      run only tests tagged "smoke"
#   ./scripts/run_tests.sh api        run only tests tagged "api"
#
# TODO: extend this script yourself (for example: choose UI or API,
# open the report afterwards, or fail with a clear message if robot is missing).
set -euo pipefail

TAG="${1:-}"
OUTPUT_DIR="results"

mkdir -p "$OUTPUT_DIR"

if [[ -n "$TAG" ]]; then
  robot --outputdir "$OUTPUT_DIR" --include "$TAG" tests/
else
  robot --outputdir "$OUTPUT_DIR" tests/
fi
