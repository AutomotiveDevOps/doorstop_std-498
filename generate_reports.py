#!/usr/bin/env python3
"""
Generate reports for MIL-STD-498 documentation.

This script generates various reports including:
- Requirements summary
- Traceability matrix  
- Coverage report

Generated via Cursor IDE with AI assistance
"""

import os
import glob
from typing import List, Dict, Tuple


def generate_requirements_summary() -> None:
    """Generate a summary of all requirements across all documents."""
    with open('reports/requirements_summary.md', 'w') as f:
        f.write('# MIL-STD-498 Requirements Summary\n\n')
        f.write('This document provides a summary of all requirements across all MIL-STD-498 documents.\n\n')
        
        documents = ['SRS', 'SDD', 'SSS', 'IRS', 'IDD', 'SSDD', 'SDP', 'STP', 'STD', 'SPS', 'SVD', 'SUM', 'CPM', 'COM', 'SCOM', 'SIOM', 'SIP', 'FSM', 'DBDD', 'OCD', 'STR', 'STRP']
        
        for doc in documents:
            doc_path = f'mil-std-498-doorstop/{doc}'
            if os.path.exists(doc_path):
                f.write(f'## {doc}\n\n')
                md_files = glob.glob(f'{doc_path}/*.md')
                for md_file in sorted(md_files):
                    with open(md_file, 'r') as md:
                        content = md.read()
                        # Extract requirement ID and title
                        lines = content.split('\n')
                        req_id = ''
                        title = ''
                        for line in lines:
                            if line.startswith('uid:'):
                                req_id = line.split(':', 1)[1].strip()
                            elif line.startswith('title:'):
                                title = line.split(':', 1)[1].strip()
                                break
                        if req_id and title:
                            f.write(f'- **{req_id}**: {title}\n')
                f.write('\n')


def generate_traceability_matrix() -> None:
    """Generate a traceability matrix showing relationships between requirements."""
    with open('reports/traceability_matrix.md', 'w') as f:
        f.write('# MIL-STD-498 Traceability Matrix\n\n')
        f.write('This document shows the relationships between requirements across different documents.\n\n')
        f.write('| Document | Requirement ID | Title | Parent |\n')
        f.write('|----------|----------------|-------|--------|\n')
        
        documents = ['SRS', 'SDD', 'SSS', 'IRS', 'IDD', 'SSDD', 'SDP', 'STP', 'STD', 'SPS', 'SVD', 'SUM', 'CPM', 'COM', 'SCOM', 'SIOM', 'SIP', 'FSM', 'DBDD', 'OCD', 'STR', 'STRP']
        
        for doc in documents:
            doc_path = f'mil-std-498-doorstop/{doc}'
            if os.path.exists(doc_path):
                md_files = glob.glob(f'{doc_path}/*.md')
                for md_file in sorted(md_files):
                    with open(md_file, 'r') as md:
                        content = md.read()
                        lines = content.split('\n')
                        req_id = ''
                        title = ''
                        parent = ''
                        for line in lines:
                            if line.startswith('uid:'):
                                req_id = line.split(':', 1)[1].strip()
                            elif line.startswith('title:'):
                                title = line.split(':', 1)[1].strip()
                            elif line.startswith('parent:'):
                                parent = line.split(':', 1)[1].strip()
                        if req_id and title:
                            f.write(f'| {doc} | {req_id} | {title} | {parent} |\n')


def generate_coverage_report() -> None:
    """Generate a coverage report with metrics for all requirements."""
    with open('reports/coverage_report.md', 'w') as f:
        f.write('# MIL-STD-498 Coverage Report\n\n')
        f.write('This document provides coverage analysis and metrics for all requirements.\n\n')
        
        documents = ['SRS', 'SDD', 'SSS', 'IRS', 'IDD', 'SSDD', 'SDP', 'STP', 'STD', 'SPS', 'SVD', 'SUM', 'CPM', 'COM', 'SCOM', 'SIOM', 'SIP', 'FSM', 'DBDD', 'OCD', 'STR', 'STRP']
        total_reqs = 0
        
        for doc in documents:
            doc_path = f'mil-std-498-doorstop/{doc}'
            if os.path.exists(doc_path):
                md_files = glob.glob(f'{doc_path}/*.md')
                doc_reqs = len(md_files)
                total_reqs += doc_reqs
                f.write(f'## {doc}\n')
                f.write(f'- **Total Requirements**: {doc_reqs}\n')
                f.write(f'- **Files**: {len(md_files)}\n\n')
        
        f.write(f'## Overall Statistics\n')
        f.write(f'- **Total Documents**: 22\n')
        f.write(f'- **Total Requirements**: {total_reqs}\n')
        f.write(f'- **Average Requirements per Document**: {total_reqs/22:.1f}\n')


def main() -> None:
    """Main function to generate all reports."""
    # Create reports directory
    os.makedirs('reports', exist_ok=True)
    
    # Generate all reports
    generate_requirements_summary()
    generate_traceability_matrix()
    generate_coverage_report()
    
    print("Reports generated successfully:")
    print("- reports/requirements_summary.md")
    print("- reports/traceability_matrix.md")
    print("- reports/coverage_report.md")


if __name__ == '__main__':
    main() 