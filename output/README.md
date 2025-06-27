# MIL-STD-498 Output Directory

This directory contains the generated output files for the MIL-STD-498 Software Development and Documentation project.

## 🌐 Live Documentation

**GitHub Pages URL**: https://automotivedevops.github.io/doorstop_std-498/

The documentation is available online with full navigation and search capabilities.

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

## 📄 Generated HTML Files

### Main Navigation Files
- **`gh-pages/index.html`** - Main landing page with implementation selection
- **`gh-pages/doorstop/index.html`** - Doorstop documents index with categorized navigation
- **`gh-pages/strictdoc/index.html`** - StrictDoc documents index (placeholder)

### Requirements Documents (3 files)
- **`gh-pages/doorstop/SRS.html`** - Software Requirements Specification
  - Defines functional and non-functional software requirements
  - Includes requirement traceability and validation criteria
  - 371 lines of comprehensive requirements documentation

- **`gh-pages/doorstop/IRS.html`** - Interface Requirements Specification
  - Defines interface requirements and protocols
  - Specifies data formats and communication standards
  - 171 lines of interface specifications

- **`gh-pages/doorstop/SPS.html`** - Software Product Specification
  - Specifies software product characteristics and features
  - Defines product boundaries and capabilities
  - 151 lines of product specifications

### Design Documents (5 files)
- **`gh-pages/doorstop/SSS.html`** - System/Subsystem Specification
  - System and subsystem specifications
  - Architecture and component definitions
  - 331 lines of system specifications

- **`gh-pages/doorstop/SSDD.html`** - System/Subsystem Design Description
  - System and subsystem design descriptions
  - Detailed design documentation
  - 151 lines of design descriptions

- **`gh-pages/doorstop/SDD.html`** - Software Design Description
  - Software design and architecture
  - Component and module specifications
  - 388 lines of software design documentation

- **`gh-pages/doorstop/IDD.html`** - Interface Design Description
  - Interface design and specifications
  - API and protocol definitions
  - 146 lines of interface design

- **`gh-pages/doorstop/DBDD.html`** - Database Design Description
  - Database design and schema
  - Data models and relationships
  - 151 lines of database design

### Support Documents (8 files)
- **`gh-pages/doorstop/SDP.html`** - Software Development Plan
  - Software development planning and management
  - Project schedules and resource allocation
  - 153 lines of development planning

- **`gh-pages/doorstop/STP.html`** - Software Test Plan
  - Software testing strategy and planning
  - Test methodologies and procedures
  - 153 lines of test planning

- **`gh-pages/doorstop/STD.html`** - Software Test Description
  - Software test procedures and criteria
  - Test case specifications
  - 140 lines of test descriptions

- **`gh-pages/doorstop/STR.html`** - Software Test Report
  - Software test results and analysis
  - Test execution summaries
  - 139 lines of test reporting

- **`gh-pages/doorstop/STRP.html`** - Software Transition Plan
  - Software transition and deployment planning
  - Deployment strategies and procedures
  - 152 lines of transition planning

- **`gh-pages/doorstop/SUM.html`** - Software User Manual
  - Software user documentation and guides
  - User interface and operation instructions
  - 152 lines of user documentation

- **`gh-pages/doorstop/SVD.html`** - Software Version Description
  - Software version and release information
  - Version history and change tracking
  - 151 lines of version documentation

### Additional Documents (7 files)
- **`gh-pages/doorstop/CPM.html`** - Computer Programming Manual
  - Computer programming and coding standards
  - Development guidelines and best practices
  - 127 lines of programming documentation

- **`gh-pages/doorstop/COM.html`** - Computer Operations Manual
  - Computer operations and procedures
  - System operation guidelines
  - 139 lines of operations documentation

- **`gh-pages/doorstop/SCOM.html`** - Software Configuration Management
  - Software configuration management procedures
  - Version control and change management
  - 139 lines of configuration management

- **`gh-pages/doorstop/SIOM.html`** - Software Installation and Operations Manual
  - Software installation and operations procedures
  - Deployment and maintenance instructions
  - 158 lines of installation documentation

- **`gh-pages/doorstop/SIP.html`** - Software Installation Plan
  - Software installation planning and procedures
  - Deployment strategies and requirements
  - 157 lines of installation planning

- **`gh-pages/doorstop/FSM.html`** - Firmware Support Manual
  - Firmware support and maintenance procedures
  - Hardware integration and support
  - 132 lines of firmware documentation

- **`gh-pages/doorstop/OCD.html`** - Operator Control Document
  - Operator control and interface documentation
  - User interface specifications
  - 145 lines of operator documentation

## Usage

### Web Browsing
1. Open `gh-pages/index.html` in a web browser
2. Navigate between Doorstop and StrictDoc implementations
3. Browse individual MIL-STD-498 documents

### GitHub Pages Deployment
The `gh-pages/` directory is structured for GitHub Pages deployment:
- Copy contents to a GitHub repository
- Enable GitHub Pages in repository settings
- Access via https://automotivedevops.github.io/doorstop_std-498/

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
- **Total Files**: 23 HTML documents
- **Total Lines**: ~3,500 lines of documentation

### StrictDoc Implementation
- **Tool**: StrictDoc
- **Format**: Structured document format (.sdoc)
- **Features**: Semantic markup, cross-references, validation
- **Status**: Source files ready, HTML generation pending
- **Total Files**: 20 source documents ready

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
- **Repository**: https://github.com/AutomotiveDevOps/doorstop_std-498 