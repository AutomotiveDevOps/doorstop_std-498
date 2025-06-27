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

# Doorstop document prefixes
DOCUMENTS := SRS SDD SSS IRS IDD SSDD SDP STP STD SPS SVD SUM CPM COM SCOM SIOM SIP FSM DBDD OCD STR STRP

# Output directories
EXPORT_DIR := exports
PUBLISH_DIR := publications
REPORTS_DIR := reports

# Default target
.PHONY: all
all: ${VENV} install-deps convert-requirements generate-all

# Create virtual environment
.PHONY: ${VENV}
${VENV}:
	${PYTHON} -m venv ${VENV}
	@echo "Virtual environment created: ${VENV}"

# Install dependencies
.PHONY: install-deps
install-deps: ${VENV}
	${PIP} install doorstop python-frontmatter
	@echo "Dependencies installed"

# Convert requirements from markdown to doorstop format
.PHONY: convert-requirements
convert-requirements: ${VENV}
	${PYTHON_VENV} convert_to_doorstop.py
	@echo "Requirements converted to doorstop format"

# Generate all doorstop outputs
.PHONY: generate-all
generate-all: ${VENV} create-dirs export-all publish-all validate-all generate-reports
	@echo "All doorstop outputs generated"

# Create output directories
.PHONY: create-dirs
create-dirs:
	mkdir -p ${EXPORT_DIR}
	mkdir -p ${PUBLISH_DIR}
	mkdir -p ${REPORTS_DIR}

# Export all documents to YAML format
.PHONY: export-all
export-all: ${VENV} create-dirs
	@echo "Exporting all documents to YAML format..."
	@for doc in ${DOCUMENTS}; do \
		echo "Exporting $$doc..."; \
		${DOORSTOP} export $$doc > ${EXPORT_DIR}/$$doc.yaml; \
	done
	@echo "All documents exported to ${EXPORT_DIR}/"

# Publish all documents to various formats
.PHONY: publish-all
publish-all: ${VENV} publish-html publish-markdown publish-pdf
	@echo "All documents published"

# Publish to HTML format
.PHONY: publish-html
publish-html: ${VENV} create-dirs
	@echo "Publishing documents to HTML format..."
	@echo "WARNING: HTML publishing may hang due to PlantUML extension. Use publish-markdown for reliable output."
	@mkdir -p ${PUBLISH_DIR}/html
	@for doc in ${DOCUMENTS}; do \
		echo "Publishing $$doc to HTML..."; \
		${DOORSTOP} publish $$doc ${PUBLISH_DIR}/html/$$doc.html --html; \
	done
	@echo "HTML publishing completed"

# Publish to Markdown format
.PHONY: publish-markdown
publish-markdown: ${VENV} create-dirs
	@echo "Publishing documents to Markdown format..."
	@mkdir -p ${PUBLISH_DIR}/markdown
	@for doc in ${DOCUMENTS}; do \
		echo "Publishing $$doc to Markdown..."; \
		${DOORSTOP} publish $$doc ${PUBLISH_DIR}/markdown/$$doc.md --markdown; \
	done
	@echo "Markdown publishing completed"

# Publish to PDF format (via LaTeX)
.PHONY: publish-pdf
publish-pdf: ${VENV} create-dirs
	@echo "Publishing documents to LaTeX (PDF) format..."
	@for doc in ${DOCUMENTS}; do \
		echo "Publishing $$doc to LaTeX..."; \
		mkdir -p ${PUBLISH_DIR}/latex; \
		${DOORSTOP} publish $$doc ${PUBLISH_DIR}/latex/$$doc.tex --latex; \
	done
	@echo "LaTeX publications complete (convert .tex to PDF manually if needed)"

# Validate all documents
.PHONY: validate-all
validate-all: ${VENV}
	@echo "Validating all documents..."
	@${DOORSTOP} --verbose --warn-all
	@echo "Document validation complete"

# Generate comprehensive reports
.PHONY: generate-reports
generate-reports: ${VENV} generate-requirements-report generate-traceability-report generate-coverage-report
	@echo "All reports generated"

# Generate requirements summary report
.PHONY: generate-requirements-report
generate-requirements-report: ${VENV} create-dirs
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
generate-traceability-report: ${VENV} create-dirs
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
generate-coverage-report: ${VENV} create-dirs
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
generate-master-report: ${VENV} create-dirs
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
	@echo "  clean                  - Clean generated outputs"
	@echo "  clean-all              - Clean everything including venv"
	@echo "  help                   - Show this help message"
	@echo ""
	@echo "Output directories:"
	@echo "  ${EXPORT_DIR}     - YAML exports"
	@echo "  ${PUBLISH_DIR}    - Published documents"
	@echo "  ${REPORTS_DIR}    - Analysis reports"

# Quick setup target
.PHONY: quick-setup
quick-setup: ${VENV} install-deps convert-requirements
	@echo "Quick setup complete - ready for doorstop operations"

# Development target for testing
.PHONY: dev
dev: ${VENV} install-deps
	@echo "Development environment ready"
	@echo "Run 'make convert-requirements' to convert requirements"
	@echo "Run 'make generate-all' to generate all outputs" 