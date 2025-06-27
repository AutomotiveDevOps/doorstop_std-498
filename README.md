# MIL-STD-498 Requirements Documentation

A comprehensive implementation of the MIL-STD-498 Software Development and Documentation standards using the Doorstop requirements management system.

## 📋 Overview

This project provides a complete set of MIL-STD-498 compliant documents, including:

- **Requirements Documents**: SRS, SSS, IRS
- **Design Documents**: SDD, SSDD, IDD, DBDD
- **Planning Documents**: SDP, STP, SIP, STRP
- **Testing Documents**: STD, STR
- **Product Documents**: SPS, SVD
- **User Documentation**: SUM, CPM, COM, SCOM, SIOM, OCD, FSM

## 🏗️ Project Structure

```
doorstop_std-498/
├── mil-std-498-requirements/     # Source markdown files
├── mil-std-498-doorstop/         # Doorstop project structure
├── publications/                 # Generated outputs
│   ├── html/                    # HTML documents
│   ├── markdown/                # Markdown documents
│   └── template/                # CSS and template files
├── reports/                     # Analysis reports
├── template/                    # Doorstop templates
├── venv/                        # Python virtual environment
├── Makefile                     # Build automation
├── convert_to_doorstop.py       # Conversion script
└── requirements.txt             # Python dependencies
```

## 🚀 Quick Start

### Prerequisites

- Python 3.12+
- Make
- Git

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd doorstop_std-498
   ```

2. **Set up the environment**:
   ```bash
   make setup
   ```

3. **Build all documents**:
   ```bash
   make all
   ```

## 📖 Usage

### Available Make Targets

- `make setup` - Create virtual environment and install dependencies
- `make clean` - Remove generated outputs
- `make convert-requirements` - Convert source markdown to Doorstop format
- `make validate` - Validate Doorstop documents
- `make publish-markdown` - Generate markdown publications
- `make publish-html` - Generate HTML publications (may hang due to PlantUML)
- `make reports` - Generate analysis reports
- `make all` - Run complete build process

### Working with Requirements

1. **View documents**:
   ```bash
   # Start Doorstop server
   make serve
   # Open http://localhost:7867 in browser
   ```

2. **Edit requirements**:
   - Source files are in `mil-std-498-requirements/`
   - Doorstop files are in `mil-std-498-doorstop/`
   - Regenerate with `make convert-requirements`

3. **Validate requirements**:
   ```bash
   make validate
   ```

### Publishing

- **Markdown**: `make publish-markdown` (recommended)
- **HTML**: `make publish-html` (may hang due to PlantUML extension)
- **Reports**: `make reports`

## 🌐 GitHub Pages

The project automatically publishes to GitHub Pages via GitHub Actions. The workflow:

1. Builds the project using Make
2. Converts markdown to HTML using Pandoc
3. Creates a comprehensive index page
4. Deploys to GitHub Pages

**Live Documentation**: [View on GitHub Pages](https://your-username.github.io/your-repo/)

## 📊 Document Categories

### Requirements Documents
- **SRS** - Software Requirements Specification
- **SSS** - System Specification  
- **IRS** - Interface Requirements Specification

### Design Documents
- **SDD** - Software Design Document
- **SSDD** - System Design Document
- **IDD** - Interface Design Document
- **DBDD** - Database Design Document

### Planning Documents
- **SDP** - Software Development Plan
- **STP** - Software Test Plan
- **SIP** - Software Installation Plan
- **STRP** - Software Transition Plan

### Testing Documents
- **STD** - Software Test Description
- **STR** - Software Test Report

### Product Documents
- **SPS** - Software Product Specification
- **SVD** - Software Version Description

### User Documentation
- **SUM** - Software User Manual
- **CPM** - Computer Programming Manual
- **COM** - Computer Operations Manual
- **SCOM** - Software Configuration Management Manual
- **SIOM** - Software Installation and Operations Manual
- **OCD** - Operator Control Document
- **FSM** - Firmware Support Manual

## 🔧 Technical Details

### Technology Stack
- **Doorstop 3.0.2** - Requirements management system
- **Python 3.12** - Runtime environment
- **Make** - Build automation
- **Pandoc** - Document conversion
- **GitHub Actions** - CI/CD pipeline

### File Formats
- **Source**: Markdown with YAML frontmatter
- **Doorstop**: Markdown with Doorstop metadata
- **Output**: HTML, Markdown, LaTeX
- **Reports**: Markdown with analysis

### Known Issues
- HTML publishing may hang due to PlantUML extension
- Use markdown publishing for reliable output
- Some documents have duplicate levels (warnings are normal)

## 📈 Reports

The system generates several analysis reports:

- **Requirements Summary** - Overview of all requirements
- **Traceability Matrix** - Requirements relationships
- **Coverage Report** - Requirements coverage analysis

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `make all` to ensure everything builds
5. Submit a pull request

## 📄 License

This project is open source. Please check the LICENSE file for details.

## 🔗 Links

- [MIL-STD-498 Standard](https://en.wikipedia.org/wiki/MIL-STD-498)
- [Doorstop Documentation](https://doorstop.readthedocs.io/)
- [GitHub Pages](https://pages.github.com/)

---

**Generated using Doorstop Requirements Management System** 