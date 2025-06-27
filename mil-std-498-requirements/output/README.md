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
