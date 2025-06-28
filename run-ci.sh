#!/bin/bash
#/**
# * This code written by Claude Sonnet 4 (claude-3-5-sonnet-20241022)
# * Generated via Cursor IDE (cursor.sh) with AI assistance
# * Model: Anthropic Claude 3.5 Sonnet
# * Generation timestamp: 2024-06-27
# * Context: CI/CD runner script for MIL-STD-498 doorstop automation
# * 
# * Technical details:
# * - LLM: Claude 3.5 Sonnet (2024-10-22)
# * - IDE: Cursor (cursor.sh)
# * - Generation method: AI-assisted pair programming
# * - Code style: Bash script with error handling
# * - Dependencies: Python 3, doorstop (global install)
# */

# CI/CD runner script for MIL-STD-498 doorstop automation
# This script installs doorstop globally and runs the CI Makefile

set -e  # Exit on any error

echo "=== MIL-STD-498 Doorstop CI/CD Runner ==="
echo "Installing doorstop and dependencies globally..."

# Install dependencies globally
python3 -m pip install --upgrade pip
python3 -m pip install doorstop python-frontmatter

echo "Dependencies installed successfully!"
echo "Running doorstop automation..."

# Run the CI Makefile
if [ $# -eq 0 ]; then
    # No arguments, run the default target
    make -f Makefile.ci all
else
    # Run the specified target
    make -f Makefile.ci "$@"
fi

echo "=== CI/CD run completed successfully! ===" 