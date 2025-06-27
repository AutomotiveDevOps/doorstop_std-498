#!/bin/bash

# Exit on any error
set -e

INPUT="SSS.md"
if [ -z "$OUTPUT_DIR" ]; then
    OUTPUT_DIR="$(dirname "$0")/output"
fi

echo "Generating output files to: $OUTPUT_DIR"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# The required output.
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.docx" --standalone
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.pptx" --standalone
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.pdf" --standalone

# Standard output with minimal command line options.
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.txt" --standalone
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.html" --standalone --embed-resources
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.odt" --standalone

# Specify output format for shared extension.
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements_toc.html" --standalone --embed-resources --table-of-contents

# Slideshows
TO="slidy"
pandoc "$INPUT" --output="$OUTPUT_DIR/Requirements.$TO.html" --to="$TO" --standalone

echo "Basic output files generated successfully!"
echo ""
echo "Note: Template-based outputs (Eisvogel PDFs, Bootstrap HTML) require additional"
echo "pandoc templates to be installed. See README.md for template installation instructions." 