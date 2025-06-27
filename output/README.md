# MIL-STD-498 Output Directory

This directory contains the generated output files for the MIL-STD-498 Software Development and Documentation project.

## Directory Structure

```
output/
├── gh-pages/                    # GitHub Pages compatible output
│   ├── index.html              # Main index page
│   ├── doorstop/               # Doorstop implementation
│   │   ├── index.html          # Doorstop documents index
│   │   ├── SRS.html            # Software Requirements Specification
│   │   ├── SDD.html            # Software Design Description
│   │   └── ...                 # All other doorstop HTML files
│   └── strictdoc/              # StrictDoc implementation
│       └── index.html          # StrictDoc documents index (placeholder)
├── exports/                     # YAML exports (if generated)
├── publications/               # Published documents
│   ├── html/                   # HTML publications
│   ├── markdown/               # Markdown publications
│   └── latex/                  # LaTeX publications
└── reports/                    # Generated reports
```

## Usage

### Web Browsing
1. Open `gh-pages/index.html` in a web browser
2. Navigate between Doorstop and StrictDoc implementations
3. Browse individual MIL-STD-498 documents

### GitHub Pages Deployment
The `gh-pages/` directory is structured for GitHub Pages deployment:
- Copy contents to a GitHub repository
- Enable GitHub Pages in repository settings
- Access via `https://username.github.io/repository-name/`

### Local Development
For local development and testing:
```bash
# Start a local web server
python -m http.server 8000

# Navigate to http://localhost:8000/output/gh-pages/
```

## Document Categories

### Requirements Documents
- **SRS** - Software Requirements Specification
- **IRS** - Interface Requirements Specification  
- **SPS** - Software Product Specification

### Design Documents
- **SSS** - System/Subsystem Specification
- **SSDD** - System/Subsystem Design Description
- **SDD** - Software Design Description
- **IDD** - Interface Design Description
- **DBDD** - Database Design Description

### Support Documents
- **SDP** - Software Development Plan
- **STP** - Software Test Plan
- **STD** - Software Test Description
- **STR** - Software Test Report
- **STRP** - Software Transition Plan
- **SUM** - Software User Manual
- **SVD** - Software Version Description

### Additional Documents
- **CPM** - Computer Programming Manual
- **COM** - Computer Operations Manual
- **SCOM** - Software Configuration Management
- **SIOM** - Software Installation and Operations Manual
- **SIP** - Software Installation Plan
- **FSM** - Firmware Support Manual
- **OCD** - Operator Control Document

## Implementation Details

### Doorstop Implementation
- **Tool**: Doorstop 3.0.2
- **Format**: Markdown-based requirements
- **Features**: Full traceability, validation, multiple export formats
- **Status**: Complete with HTML generation

### StrictDoc Implementation
- **Tool**: StrictDoc
- **Format**: Structured document format (.sdoc)
- **Features**: Semantic markup, cross-references, validation
- **Status**: Source files ready, HTML generation pending

## Generation Commands

```bash
# Generate all doorstop outputs
make generate-all

# Generate only HTML publications
make publish-html

# Generate only doorstop exports
make export-all

# Generate reports
make generate-reports
```

## File Formats

- **HTML**: Web-browsable documents with Bootstrap styling
- **Markdown**: Plain text format for version control
- **LaTeX**: Print-ready PDF generation
- **YAML**: Machine-readable exports for integration

## Maintenance

- Generated files are automatically updated when source documents change
- Index files are regenerated to reflect current document structure
- Reports provide analysis of document coverage and traceability
- All outputs include proper attribution and metadata

## Technical Attribution

This output was generated using:
- **LLM**: Claude 3.5 Sonnet (2024-10-22)
- **IDE**: Cursor (cursor.sh)
- **Generation Method**: AI-assisted pair programming
- **Tools**: Doorstop 3.0.2, StrictDoc
- **Standard**: MIL-STD-498 Software Development and Documentation 