#!/bin/bash

set -eu

cd example/
dart run custom_lint > custom_lint_output || true
diff custom_lint_output custom_lint_output.ref
