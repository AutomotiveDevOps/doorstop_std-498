#!/bin/bash

# This code written by Claude Sonnet 4 (claude-3-5-sonnet-20241022)
# Generated via Cursor IDE (cursor.sh) with AI assistance
# Model: Anthropic Claude 3.5 Sonnet
# Generation timestamp: 2024-06-26
# Context: Comprehensive script to generate outputs for all MIL-STD-498 document types
# 
# Technical details:
# - LLM: Claude 3.5 Sonnet (2024-10-22)
# - IDE: Cursor (cursor.sh)
# - Generation method: AI-assisted pair programming
# - Code style: Bash script with proper error handling
# - Dependencies: pandoc, texlive, make

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Function to generate outputs for a single document
generate_document_outputs() {
    local input_file="$1"
    local output_dir="$2"
    local doc_name="$3"
    
    print_status "Generating outputs for $doc_name..."
    
    # Create output directory
    mkdir -p "$output_dir"
    
    # Generate different output formats
    if pandoc "$input_file" -o "$output_dir/${doc_name}.pdf" --pdf-engine=pdflatex 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}.pdf"
    else
        print_warning "Failed to generate PDF for $doc_name"
    fi
    
    if pandoc "$input_file" -o "$output_dir/${doc_name}.html" --standalone 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}.html"
    else
        print_warning "Failed to generate HTML for $doc_name"
    fi
    
    if pandoc "$input_file" -o "$output_dir/${doc_name}.docx" 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}.docx"
    else
        print_warning "Failed to generate DOCX for $doc_name"
    fi
    
    if pandoc "$input_file" -o "$output_dir/${doc_name}.odt" 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}.odt"
    else
        print_warning "Failed to generate ODT for $doc_name"
    fi
    
    if pandoc "$input_file" -o "$output_dir/${doc_name}.txt" 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}.txt"
    else
        print_warning "Failed to generate TXT for $doc_name"
    fi
    
    if pandoc "$input_file" -o "$output_dir/${doc_name}.pptx" 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}.pptx"
    else
        print_warning "Failed to generate PPTX for $doc_name"
    fi
    
    # Generate table of contents HTML
    if pandoc "$input_file" -o "$output_dir/${doc_name}_toc.html" --toc --standalone 2>/dev/null; then
        print_success "Generated $output_dir/${doc_name}_toc.html"
    else
        print_warning "Failed to generate TOC HTML for $doc_name"
    fi
}

# Main execution
print_status "Starting MIL-STD-498 document generation..."

# Create main output directory
mkdir -p output

# Define document categories and their files (alphabetical order)
declare -A document_categories=(
    ["Computer-Operations"]="COM.md"
    ["Configuration-Management"]="SCOM.md"
    ["Database-Design"]="DBDD.md"
    ["Development-Planning"]="SDP.md"
    ["Firmware-Support"]="FSM.md"
    ["Interface-Design"]="IDD.md"
    ["Interface-Requirements"]="IRS.md"
    ["Installation-Planning"]="SIP.md"
    ["Installation-Operations"]="SIOM.md"
    ["Operator-Control"]="OCD.md"
    ["Programming-Manual"]="CPM.md"
    ["Requirements"]="SRS.md"
    ["Software-Design"]="SDD.md"
    ["Software-Product"]="SPS.md"
    ["System-Design"]="SSDD.md"
    ["System-Specification"]="SSS.md"
    ["Testing-Description"]="STD.md"
    ["Testing-Plan"]="STP.md"
    ["Transition-Planning"]="STRP.md"
    ["User-Manual"]="SUM.md"
    ["Version-Description"]="SVD.md"
)

# Generate outputs for each document
for category in "${!document_categories[@]}"; do
    input_file="${document_categories[$category]}"
    doc_name="${input_file%.*}"
    output_dir="output/$category"
    
    if [[ -f "$input_file" ]]; then
        generate_document_outputs "$input_file" "$output_dir" "$doc_name"
    else
        print_error "Input file $input_file not found"
    fi
done

# Generate combined outputs
print_status "Generating combined outputs..."

# Create a combined markdown file with all documents
combined_file="output/All_MIL_STD_498_Documents.md"
echo "# MIL-STD-498 Document Collection" > "$combined_file"
echo "" >> "$combined_file"
echo "This document contains all MIL-STD-498 document types in alphabetical order." >> "$combined_file"
echo "" >> "$combined_file"

for category in $(printf '%s\n' "${!document_categories[@]}" | sort); do
    input_file="${document_categories[$category]}"
    if [[ -f "$input_file" ]]; then
        echo "## $category" >> "$combined_file"
        echo "" >> "$combined_file"
        cat "$input_file" >> "$combined_file"
        echo "" >> "$combined_file"
        echo "---" >> "$combined_file"
        echo "" >> "$combined_file"
    fi
done

# Generate combined outputs
if pandoc "$combined_file" -o "output/All_MIL_STD_498_Documents.pdf" --pdf-engine=pdflatex 2>/dev/null; then
    print_success "Generated output/All_MIL_STD_498_Documents.pdf"
else
    print_warning "Failed to generate combined PDF"
fi

if pandoc "$combined_file" -o "output/All_MIL_STD_498_Documents.html" --standalone 2>/dev/null; then
    print_success "Generated output/All_MIL_STD_498_Documents.html"
else
    print_warning "Failed to generate combined HTML"
fi

if pandoc "$combined_file" -o "output/All_MIL_STD_498_Documents.docx" 2>/dev/null; then
    print_success "Generated output/All_MIL_STD_498_Documents.docx"
else
    print_warning "Failed to generate combined DOCX"
fi

# Create README for output directory
cat > output/README.md << 'EOF'
# MIL-STD-498 Document Outputs

This directory contains generated outputs for all MIL-STD-498 document types.

## Directory Structure

The outputs are organized by document category:

- **Computer-Operations/**: Computer Operation Manual (COM)
- **Configuration-Management/**: Software Configuration Management Plan (SCOM)
- **Database-Design/**: Database Design Document (DBDD)
- **Development-Planning/**: Software Development Plan (SDP)
- **Firmware-Support/**: Firmware Support Manual (FSM)
- **Interface-Design/**: Interface Design Document (IDD)
- **Interface-Requirements/**: Interface Requirements Specification (IRS)
- **Installation-Planning/**: Software Installation Plan (SIP)
- **Installation-Operations/**: Software Installation and Operation Manual (SIOM)
- **Operator-Control/**: Operator Control Document (OCD)
- **Programming-Manual/**: Computer Programming Manual (CPM)
- **Requirements/**: Software Requirements Specification (SRS)
- **Software-Design/**: Software Design Document (SDD)
- **Software-Product/**: Software Product Specification (SPS)
- **System-Design/**: Software System Design Document (SSDD)
- **System-Specification/**: System/Subsystem Specification (SSS)
- **Testing-Description/**: Software Test Description (STD)
- **Testing-Plan/**: Software Test Plan (STP)
- **Transition-Planning/**: Software Transition Plan (STRP)
- **User-Manual/**: Software User Manual (SUM)
- **Version-Description/**: Software Version Description (SVD)

## Output Formats

Each document is generated in multiple formats:
- PDF (.pdf)
- HTML (.html)
- Microsoft Word (.docx)
- OpenDocument Text (.odt)
- Plain Text (.txt)
- PowerPoint (.pptx)
- Table of Contents HTML (_toc.html)

## Combined Documents

- **All_MIL_STD_498_Documents.pdf**: All documents combined in PDF format
- **All_MIL_STD_498_Documents.html**: All documents combined in HTML format
- **All_MIL_STD_498_Documents.docx**: All documents combined in Word format

## Usage

To regenerate all outputs, run:
```bash
./generate_all_outputs.sh
```

To generate outputs for a specific document, run:
```bash
./generate_output.sh <document_name>.md
```
