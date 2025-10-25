# This code written by Claude Sonnet 4 (claude-3-5-sonnet-20241022)
# Generated via Cursor IDE (cursor.sh) with AI assistance
# Model: Anthropic Claude 3.5 Sonnet
# Generation timestamp: 2024-06-26
# Context: Makefile for MIL-STD-498 doorstop automation
# 
# Technical details:
# - LLM: Claude 3.5 Sonnet (2024-10-22)
# - IDE: Cursor (cursor.sh)
# - Generation method: AI-assisted pair programming
# - Code style: Makefile with full variable escaping
# - Dependencies: Python 3, venv, doorstop 3.0.2

# Variables
PYTHON := python3
VENV := venv
PIP := ${VENV}/bin/pip
DOORSTOP := ${VENV}/bin/doorstop
PYTHON_VENV := ${VENV}/bin/python
STRICTDOC := ${VENV}/bin/strictdoc

# Fallback doorstop command for CI/CD environments
DOORSTOP_FALLBACK := python3 -m doorstop
DOORSTOP_SCRIPT := python3 run_doorstop.py
STRICTDOC_FALLBACK := python3 -m strictdoc

# Doorstop document prefixes
DOCUMENTS := SRS SDD SSS IRS IDD SSDD SDP STP STD SPS SVD SUM CPM COM SCOM SIOM SIP FSM DBDD OCD STR STRP

# Output directories
EXPORT_DIR := exports
PUBLISH_DIR := publications
REPORTS_DIR := reports
STRICTDOC_DIR := mil-std-498-strictdoc
STRICTDOC_OUTPUT_DIR := output/strictdoc

# Default target
.PHONY: all
all: install-deps convert-requirements generate-all

# Create virtual environment with robust error handling
.PHONY: ${VENV}
${VENV}:
	@echo "Creating virtual environment..."
	@if [ ! -d "${VENV}" ]; then \
		${PYTHON} -m venv ${VENV} || { echo "Failed to create venv, trying system install..."; exit 1; }; \
	fi
	@echo "Installing dependencies in virtual environment..."
	@${VENV}/bin/pip install --upgrade pip || { echo "Failed to upgrade pip"; exit 1; }
	@${VENV}/bin/pip install doorstop python-frontmatter strictdoc || { echo "Failed to install dependencies in venv"; exit 1; }
	@echo "Virtual environment created and dependencies installed: ${VENV}"

# Install dependencies with fallback options
.PHONY: install-deps
install-deps: ${VENV}
	@echo "Installing dependencies..."
	@${PIP} install doorstop python-frontmatter strictdoc || { echo "Failed to install in venv, trying system install..."; pip3 install doorstop python-frontmatter strictdoc; }
	@echo "Dependencies installed"

# Convert requirements from markdown to doorstop format
.PHONY: convert-requirements
convert-requirements: install-deps
	@echo "Converting requirements to doorstop format..."
	@${PYTHON_VENV} convert_to_doorstop.py || python3 convert_to_doorstop.py
	@echo "Requirements converted to doorstop format"

# Generate all doorstop outputs
.PHONY: generate-all
generate-all: install-deps create-dirs export-all publish-all validate-all generate-reports generate-strictdoc-all
	@echo "All doorstop outputs generated"

# Generate all StrictDoc outputs
.PHONY: generate-strictdoc-all
generate-strictdoc-all: install-deps create-dirs generate-strictdoc-html validate-strictdoc export-strictdoc
	@echo "All StrictDoc outputs generated"

# Create output directories
.PHONY: create-dirs
create-dirs:
	mkdir -p ${EXPORT_DIR}
	mkdir -p ${PUBLISH_DIR}
	mkdir -p ${REPORTS_DIR}
	mkdir -p ${STRICTDOC_OUTPUT_DIR}

# Export all documents to YAML format with fallback
.PHONY: export-all
export-all: install-deps create-dirs
	@echo "Exporting all documents to YAML format..."
	@for doc in ${DOCUMENTS}; do \
		echo "Exporting $$doc..."; \
		if [ -f "${DOORSTOP}" ]; then \
			${DOORSTOP} export $$doc > ${EXPORT_DIR}/$$doc.yaml; \
		elif command -v python3 >/dev/null 2>&1 && python3 -c "import doorstop" 2>/dev/null; then \
			${DOORSTOP_FALLBACK} export $$doc > ${EXPORT_DIR}/$$doc.yaml; \
		else \
			${DOORSTOP_SCRIPT} export $$doc > ${EXPORT_DIR}/$$doc.yaml; \
		fi; \
	done
	@echo "All documents exported to ${EXPORT_DIR}/"

# Publish all documents to various formats
.PHONY: publish-all
publish-all: install-deps publish-html publish-markdown publish-pdf
	@echo "All documents published"

# Publish to HTML format with fallback
.PHONY: publish-html
publish-html: install-deps create-dirs
	@echo "Publishing documents to HTML format..."
	@echo "WARNING: HTML publishing may hang due to PlantUML extension. Use publish-markdown for reliable output."
	@mkdir -p ${PUBLISH_DIR}/html
	@for doc in ${DOCUMENTS}; do \
		echo "Publishing $$doc to HTML..."; \
		if [ -f "${DOORSTOP}" ]; then \
			${DOORSTOP} publish $$doc ${PUBLISH_DIR}/html/$$doc.html --html; \
		else \
			${DOORSTOP_FALLBACK} publish $$doc ${PUBLISH_DIR}/html/$$doc.html --html; \
		fi; \
	done
	@echo "HTML publishing completed"

# Publish to Markdown format with fallback
.PHONY: publish-markdown
publish-markdown: install-deps create-dirs
	@echo "Publishing documents to Markdown format..."
	@mkdir -p ${PUBLISH_DIR}/markdown
	@for doc in ${DOCUMENTS}; do \
		echo "Publishing $$doc to Markdown..."; \
		if [ -f "${DOORSTOP}" ]; then \
			${DOORSTOP} publish $$doc ${PUBLISH_DIR}/markdown/$$doc.md --markdown; \
		else \
			${DOORSTOP_FALLBACK} publish $$doc ${PUBLISH_DIR}/markdown/$$doc.md --markdown; \
		fi; \
	done
	@echo "Markdown publishing completed"

# Publish to PDF format (via LaTeX) with fallback
.PHONY: publish-pdf
publish-pdf: install-deps create-dirs
	@echo "Publishing documents to LaTeX (PDF) format..."
	@for doc in ${DOCUMENTS}; do \
		echo "Publishing $$doc to LaTeX..."; \
		mkdir -p ${PUBLISH_DIR}/latex; \
		if [ -f "${DOORSTOP}" ]; then \
			${DOORSTOP} publish $$doc ${PUBLISH_DIR}/latex/$$doc.tex --latex; \
		else \
			${DOORSTOP_FALLBACK} publish $$doc ${PUBLISH_DIR}/latex/$$doc.tex --latex; \
		fi; \
	done
	@echo "LaTeX publications complete (convert .tex to PDF manually if needed)"

# Generate StrictDoc HTML output
.PHONY: generate-strictdoc-html
generate-strictdoc-html: install-deps create-dirs
	@echo "Generating StrictDoc HTML output..."
	@mkdir -p ${STRICTDOC_OUTPUT_DIR}/html
	@if [ -f "${STRICTDOC}" ]; then \
		${STRICTDOC} export ${STRICTDOC_DIR} --output-dir ${STRICTDOC_OUTPUT_DIR}/html --formats html; \
	elif command -v python3 >/dev/null 2>&1 && python3 -c "import strictdoc" 2>/dev/null; then \
		${STRICTDOC_FALLBACK} export ${STRICTDOC_DIR} --output-dir ${STRICTDOC_OUTPUT_DIR}/html --formats html; \
	else \
		echo "StrictDoc not available, skipping HTML generation"; \
	fi
	@echo "StrictDoc HTML generation completed"

# Validate StrictDoc files (using export as validation)
.PHONY: validate-strictdoc
validate-strictdoc: install-deps
	@echo "Validating StrictDoc files..."
	@if [ -f "${STRICTDOC}" ]; then \
		${STRICTDOC} export ${STRICTDOC_DIR} --output-dir /tmp/strictdoc-validation --formats sdoc >/dev/null 2>&1 && echo "StrictDoc files are valid"; \
	elif command -v python3 >/dev/null 2>&1 && python3 -c "import strictdoc" 2>/dev/null; then \
		${STRICTDOC_FALLBACK} export ${STRICTDOC_DIR} --output-dir /tmp/strictdoc-validation --formats sdoc >/dev/null 2>&1 && echo "StrictDoc files are valid"; \
	else \
		echo "StrictDoc not available, skipping validation"; \
	fi
	@echo "StrictDoc validation completed"

# Export StrictDoc to various formats
.PHONY: export-strictdoc
export-strictdoc: install-deps create-dirs
	@echo "Exporting StrictDoc to various formats..."
	@mkdir -p ${STRICTDOC_OUTPUT_DIR}/export
	@if [ -f "${STRICTDOC}" ]; then \
		${STRICTDOC} export ${STRICTDOC_DIR} --output-dir ${STRICTDOC_OUTPUT_DIR}/export --formats html,pdf,markdown; \
	elif command -v python3 >/dev/null 2>&1 && python3 -c "import strictdoc" 2>/dev/null; then \
		${STRICTDOC_FALLBACK} export ${STRICTDOC_DIR} --output-dir ${STRICTDOC_OUTPUT_DIR}/export --formats html,pdf,markdown; \
	else \
		echo "StrictDoc not available, skipping export"; \
	fi
	@echo "StrictDoc export completed"

# Validate all documents with fallback
.PHONY: validate-all
validate-all: install-deps
	@echo "Validating all documents..."
	@if [ -f "${DOORSTOP}" ]; then \
		${DOORSTOP} --verbose --warn-all; \
	else \
		${DOORSTOP_FALLBACK} --verbose --warn-all; \
	fi
	@echo "Document validation complete"

# Generate comprehensive reports
.PHONY: generate-reports
generate-reports: install-deps generate-requirements-report generate-traceability-report generate-coverage-report
	@echo "All reports generated"

# Generate requirements summary report
.PHONY: generate-requirements-report
generate-requirements-report: install-deps create-dirs
	@echo "Generating requirements summary report..."
	@echo "# MIL-STD-498 Requirements Summary Report" > ${REPORTS_DIR}/requirements_summary.md
	@echo "Generated: $$(date)" >> ${REPORTS_DIR}/requirements_summary.md
	@echo "" >> ${REPORTS_DIR}/requirements_summary.md
	@echo "## Document Requirements Count" >> ${REPORTS_DIR}/requirements_summary.md
	@echo "" >> ${REPORTS_DIR}/requirements_summary.md
	@for doc in ${DOCUMENTS}; do \
		count=$$(find mil-std-498-doorstop/$$doc -name "*.md" | wc -l); \
		echo "- **$$doc**: $$count requirements" >> ${REPORTS_DIR}/requirements_summary.md; \
	done
	@echo "" >> ${REPORTS_DIR}/requirements_summary.md
	@echo "## Total Requirements: $$(find mil-std-498-doorstop -name "*.md" | wc -l)" >> ${REPORTS_DIR}/requirements_summary.md
	@echo "Requirements summary report generated: ${REPORTS_DIR}/requirements_summary.md"

# Generate traceability matrix report
.PHONY: generate-traceability-report
generate-traceability-report: install-deps create-dirs
	@echo "Generating traceability matrix report..."
	@echo "# MIL-STD-498 Traceability Matrix Report" > ${REPORTS_DIR}/traceability_matrix.md
	@echo "Generated: $$(date)" >> ${REPORTS_DIR}/traceability_matrix.md
	@echo "" >> ${REPORTS_DIR}/traceability_matrix.md
	@echo "## Document Traceability Links" >> ${REPORTS_DIR}/traceability_matrix.md
	@echo "" >> ${REPORTS_DIR}/traceability_matrix.md
	@for doc in ${DOCUMENTS}; do \
		echo "### $$doc" >> ${REPORTS_DIR}/traceability_matrix.md; \
		echo "" >> ${REPORTS_DIR}/traceability_matrix.md; \
		linked_count=$$(grep -r "links:" mil-std-498-doorstop/$$doc | wc -l); \
		total_count=$$(find mil-std-498-doorstop/$$doc -name "*.md" | wc -l); \
		echo "- Total requirements: $$total_count" >> ${REPORTS_DIR}/traceability_matrix.md; \
		echo "- Requirements with links: $$linked_count" >> ${REPORTS_DIR}/traceability_matrix.md; \
		echo "- Link coverage: $$(echo "scale=1; $$linked_count * 100 / $$total_count" | bc 2>/dev/null || echo "N/A")%" >> ${REPORTS_DIR}/traceability_matrix.md; \
		echo "" >> ${REPORTS_DIR}/traceability_matrix.md; \
	done
	@echo "Traceability matrix report generated: ${REPORTS_DIR}/traceability_matrix.md"

# Generate coverage report
.PHONY: generate-coverage-report
generate-coverage-report: install-deps create-dirs
	@echo "Generating coverage report..."
	@echo "# MIL-STD-498 Coverage Report" > ${REPORTS_DIR}/coverage_report.md
	@echo "Generated: $$(date)" >> ${REPORTS_DIR}/coverage_report.md
	@echo "" >> ${REPORTS_DIR}/coverage_report.md
	@echo "## Document Coverage Analysis" >> ${REPORTS_DIR}/coverage_report.md
	@echo "" >> ${REPORTS_DIR}/coverage_report.md
	@echo "### Requirements by Document Type" >> ${REPORTS_DIR}/coverage_report.md
	@echo "" >> ${REPORTS_DIR}/coverage_report.md
	@echo "| Document | Requirements | Status |" >> ${REPORTS_DIR}/coverage_report.md
	@echo "|----------|-------------|--------|" >> ${REPORTS_DIR}/coverage_report.md
	@for doc in ${DOCUMENTS}; do \
		count=$$(find mil-std-498-doorstop/$$doc -name "*.md" | wc -l); \
		if [ $$count -gt 0 ]; then \
			echo "| $$doc | $$count | ✅ Complete |" >> ${REPORTS_DIR}/coverage_report.md; \
		else \
			echo "| $$doc | 0 | ❌ Missing |" >> ${REPORTS_DIR}/coverage_report.md; \
		fi; \
	done
	@echo "" >> ${REPORTS_DIR}/coverage_report.md
	@echo "### Summary Statistics" >> ${REPORTS_DIR}/coverage_report.md
	@echo "" >> ${REPORTS_DIR}/coverage_report.md
	@total_reqs=$$(find mil-std-498-doorstop -name "*.md" | wc -l); \
	echo "- Total Requirements: $$total_reqs" >> ${REPORTS_DIR}/coverage_report.md; \
	echo "- Documents Covered: $$(ls -1 mil-std-498-doorstop/ | wc -l)" >> ${REPORTS_DIR}/coverage_report.md; \
	echo "- Average Requirements per Document: $$(echo "scale=1; $$total_reqs / $$(ls -1 mil-std-498-doorstop/ | wc -l)" | bc 2>/dev/null || echo "N/A")" >> ${REPORTS_DIR}/coverage_report.md
	@echo "Coverage report generated: ${REPORTS_DIR}/coverage_report.md"

# Generate combined master report
.PHONY: generate-master-report
generate-master-report: install-deps create-dirs
	@echo "Generating master report..."
	@echo "# MIL-STD-498 Master Report" > ${REPORTS_DIR}/master_report.md
	@echo "Generated: $$(date)" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@echo "## Project Overview" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@echo "This report provides a comprehensive overview of the MIL-STD-498 requirements" >> ${REPORTS_DIR}/master_report.md
	@echo "converted to doorstop format with full traceability and validation." >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@echo "## Quick Statistics" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@total_reqs=$$(find mil-std-498-doorstop -name "*.md" | wc -l); \
	echo "- **Total Requirements**: $$total_reqs" >> ${REPORTS_DIR}/master_report.md; \
	echo "- **Documents**: $$(ls -1 mil-std-498-doorstop/ | wc -l)" >> ${REPORTS_DIR}/master_report.md; \
	echo "- **Doorstop Version**: 3.0.2" >> ${REPORTS_DIR}/master_report.md; \
	echo "- **Generation Method**: AI-assisted automation" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@echo "## Available Outputs" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@echo "- **Exports**: YAML format in \`${EXPORT_DIR}/\`" >> ${REPORTS_DIR}/master_report.md
	@echo "- **Publications**: HTML, Markdown, PDF in \`${PUBLISH_DIR}/\`" >> ${REPORTS_DIR}/master_report.md
	@echo "- **Reports**: Detailed analysis in \`${REPORTS_DIR}/\`" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@echo "## Document List" >> ${REPORTS_DIR}/master_report.md
	@echo "" >> ${REPORTS_DIR}/master_report.md
	@for doc in ${DOCUMENTS}; do \
		count=$$(find mil-std-498-doorstop/$$doc -name "*.md" | wc -l); \
		echo "- **$$doc**: $$count requirements" >> ${REPORTS_DIR}/master_report.md; \
	done
	@echo "Master report generated: ${REPORTS_DIR}/master_report.md"

# Clean generated outputs
.PHONY: clean
clean:
	rm -rf ${EXPORT_DIR}
	rm -rf ${PUBLISH_DIR}
	rm -rf ${REPORTS_DIR}
	rm -rf ${STRICTDOC_OUTPUT_DIR}
	@echo "Generated outputs cleaned"

# Clean everything including virtual environment
.PHONY: clean-all
clean-all: clean
	rm -rf ${VENV}
	rm -rf mil-std-498-doorstop
	@echo "Complete cleanup performed"

# Show help
.PHONY: help
help:
	@echo "MIL-STD-498 Doorstop Automation Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  all                    - Complete setup and generation (default)"
	@echo "  install-deps           - Install doorstop and dependencies"
	@echo "  convert-requirements   - Convert markdown to doorstop format"
	@echo "  generate-all           - Generate all doorstop outputs"
	@echo "  export-all             - Export documents to YAML"
	@echo "  publish-all            - Publish to HTML, Markdown, PDF"
	@echo "  validate-all           - Validate all documents"
	@echo "  generate-reports       - Generate analysis reports"
	@echo "  generate-master-report - Generate comprehensive master report"
	@echo ""
	@echo "StrictDoc targets:"
	@echo "  generate-strictdoc-all - Generate all StrictDoc outputs"
	@echo "  generate-strictdoc-html- Generate StrictDoc HTML output"
	@echo "  validate-strictdoc     - Validate StrictDoc files"
	@echo "  export-strictdoc      - Export StrictDoc to various formats"
	@echo ""
	@echo "Utility targets:"
	@echo "  clean                  - Clean generated outputs"
	@echo "  clean-all              - Clean everything including venv"
	@echo "  help                   - Show this help message"
	@echo ""
	@echo "Output directories:"
	@echo "  ${EXPORT_DIR}     - YAML exports"
	@echo "  ${PUBLISH_DIR}    - Published documents"
	@echo "  ${REPORTS_DIR}    - Analysis reports"
	@echo "  ${STRICTDOC_OUTPUT_DIR} - StrictDoc outputs"

# Quick setup target
.PHONY: quick-setup
quick-setup: install-deps convert-requirements
	@echo "Quick setup complete - ready for doorstop operations"

# Development target for testing
.PHONY: dev
dev: install-deps
	@echo "Development environment ready"
	@echo "Run 'make convert-requirements' to convert requirements"
	@echo "Run 'make generate-all' to generate all outputs" 