#!/bin/bash

# Requirements Validation Script
# This script validates requirements documents for common issues and best practices

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a file exists
check_file() {
    local file="$1"
    if [ -f "$file" ]; then
        print_success "Found requirements file: $file"
        return 0
    else
        print_error "Requirements file not found: $file"
        return 1
    fi
}

# Function to validate markdown syntax
validate_markdown() {
    local file="$1"
    print_status "Validating markdown syntax for $file"
    
    if command -v markdownlint &> /dev/null; then
        if markdownlint "$file"; then
            print_success "Markdown syntax is valid"
        else
            print_error "Markdown syntax issues found"
            return 1
        fi
    else
        print_warning "markdownlint not installed, skipping markdown validation"
    fi
}

# Function to check for requirement structure
check_requirement_structure() {
    local file="$1"
    print_status "Checking requirement structure in $file"
    
    local errors=0
    local warnings=0
    
    # Check for "shall" statements
    if ! grep -q "shall" "$file"; then
        print_warning "No 'shall' statements found - requirements should use 'shall'"
        ((warnings++))
    fi
    
    # Check for requirement IDs
    if ! grep -q -E "(FR-|NFR-|TR-|UI-|TEST-|DEPLOY-)" "$file"; then
        print_warning "No requirement IDs found (FR-, NFR-, TR-, etc.)"
        ((warnings++))
    fi
    
    # Check for TODO comments
    if grep -q "TODO" "$file"; then
        print_error "TODO comments found - requirements should be complete"
        ((errors++))
    fi
    
    # Check for FIXME comments
    if grep -q "FIXME" "$file"; then
        print_error "FIXME comments found - issues should be resolved"
        ((errors++))
    fi
    
    # Check for proper heading structure
    if ! grep -q "^# " "$file"; then
        print_error "No main heading (H1) found"
        ((errors++))
    fi
    
    # Store results in global variables
    VALIDATION_ERRORS=$((VALIDATION_ERRORS + errors))
    VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + warnings))
    
    return $errors
}

# Function to check for common issues
check_common_issues() {
    local file="$1"
    print_status "Checking for common issues in $file"
    
    local errors=0
    local warnings=0
    
    # Check for vague terms
    local vague_terms=("user-friendly" "fast" "easy" "simple" "intuitive" "good" "nice")
    for term in "${vague_terms[@]}"; do
        if grep -i -q "$term" "$file"; then
            print_warning "Vague term found: '$term' - consider being more specific"
            ((warnings++))
        fi
    done
    
    # Check for passive voice
    if grep -q "will be\|can be\|should be" "$file"; then
        print_warning "Passive voice detected - use active voice with 'shall'"
        ((warnings++))
    fi
    
    # Check for missing acceptance criteria
    if ! grep -i -q "acceptance criteria\|acceptance criterion" "$file"; then
        print_warning "No acceptance criteria found - consider adding specific criteria"
        ((warnings++))
    fi
    
    # Store results in global variables
    VALIDATION_ERRORS=$((VALIDATION_ERRORS + errors))
    VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + warnings))
    
    return $errors
}

# Function to check for security considerations
check_security() {
    local file="$1"
    print_status "Checking for security considerations in $file"
    
    local errors=0
    local warnings=0
    
    # Check for potential sensitive information
    if grep -i -q "password\|secret\|key\|token\|api_key" "$file"; then
        print_warning "Potential sensitive information found - review for security"
        ((warnings++))
    fi
    
    # Check for security requirements
    if ! grep -i -q "security\|encrypt\|authenticate\|authorize" "$file"; then
        print_warning "No security requirements found - consider adding security considerations"
        ((warnings++))
    fi
    
    # Store results in global variables
    VALIDATION_ERRORS=$((VALIDATION_ERRORS + errors))
    VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + warnings))
    
    return $errors
}

# Function to generate report
generate_report() {
    local file="$1"
    local total_errors=$2
    local total_warnings=$3
    
    echo ""
    echo "=== Validation Report for $file ==="
    echo "Errors found: $total_errors"
    echo "Warnings found: $total_warnings"
    echo "Total issues found: $((total_errors + total_warnings))"
    
    if [ $total_errors -eq 0 ] && [ $total_warnings -eq 0 ]; then
        print_success "All checks passed! Requirements document looks good."
    elif [ $total_errors -eq 0 ] && [ $total_warnings -le 3 ]; then
        print_warning "Minor warnings found. Consider addressing them."
    elif [ $total_errors -eq 0 ]; then
        print_warning "Multiple warnings found. Consider addressing them."
    else
        print_error "Errors found. Please review and fix."
    fi
    
    echo ""
}

# Main validation function
validate_requirements() {
    local file="$1"
    local file_errors=0
    local file_warnings=0
    
    print_status "Starting validation of $file"
    echo ""
    
    # Check if file exists
    if ! check_file "$file"; then
        return 1
    fi
    
    # Validate markdown syntax
    if ! validate_markdown "$file"; then
        ((file_errors++))
    fi
    
    # Check requirement structure
    if ! check_requirement_structure "$file"; then
        ((file_errors++))
    fi
    
    # Check for common issues
    if ! check_common_issues "$file"; then
        ((file_errors++))
    fi
    
    # Check security considerations
    if ! check_security "$file"; then
        ((file_errors++))
    fi
    
    # Generate report
    generate_report "$file" $file_errors $file_warnings
    
    return $file_errors
}

# Main execution
main() {
    local requirements_file="${1:-SSS.md}"
    local exit_code=0
    
    # Initialize global counters
    VALIDATION_ERRORS=0
    VALIDATION_WARNINGS=0
    
    echo "Requirements Validation Tool"
    echo "============================"
    echo ""
    
    # Validate the specified file
    if ! validate_requirements "$requirements_file"; then
        exit_code=1
    fi
    
    # Check for additional requirements files
    for file in examples/*.md; do
        if [ -f "$file" ]; then
            echo ""
            if ! validate_requirements "$file"; then
                exit_code=1
            fi
        fi
    done
    
    echo ""
    echo "Validation complete!"
    
    if [ $VALIDATION_ERRORS -eq 0 ]; then
        print_success "All requirements files passed validation"
        exit_code=0
    else
        print_error "Some errors were found. Please review and fix them."
        exit_code=1
    fi
    
    if [ $VALIDATION_WARNINGS -gt 0 ]; then
        print_warning "Total warnings across all files: $VALIDATION_WARNINGS"
    fi
    
    exit $exit_code
}

# Run main function with all arguments
main "$@" 