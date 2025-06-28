#!/usr/bin/env python3
"""
Run doorstop export operations using the doorstop Python API.

This script handles exporting and validating doorstop documents.

Generated via Cursor IDE with AI assistance
"""

import os
import sys
from typing import List, Optional

try:
    import doorstop
    from doorstop import Document, Tree
    from doorstop import exporter
except ImportError:
    print("Error: doorstop package not found. Please install it with: pip install doorstop")
    sys.exit(1)


def export_document(doc_path: str, output_path: str) -> bool:
    """Export a doorstop document to YAML format."""
    try:
        print(f"Exporting {doc_path} to {output_path}...")
        
        # Change to the doorstop directory for proper document loading
        original_dir = os.getcwd()
        doorstop_dir = os.path.dirname(doc_path)
        os.chdir(doorstop_dir)
        
        # Load the document using just the document name
        doc_name = os.path.basename(doc_path)
        document = Document(doc_name)
        
        # Export to YAML using the exporter module
        exporter.export(document, output_path, '.yml')
        
        # Change back to original directory
        os.chdir(original_dir)
        
        print(f"Successfully exported {doc_path}")
        return True
    except Exception as e:
        # Change back to original directory in case of error
        try:
            os.chdir(original_dir)
        except:
            pass
        print(f"Error exporting {doc_path}: {e}")
        return False


def validate_document(doc_path: str) -> bool:
    """Validate a doorstop document."""
    try:
        print(f"Validating {doc_path}...")
        
        # Change to the doorstop directory for proper document loading
        original_dir = os.getcwd()
        doorstop_dir = os.path.dirname(doc_path)
        os.chdir(doorstop_dir)
        
        # Load the document using just the document name
        doc_name = os.path.basename(doc_path)
        document = Document(doc_name)
        
        # Validate
        document.validate()
        
        # Change back to original directory
        os.chdir(original_dir)
        
        print(f"Successfully validated {doc_path}")
        return True
    except Exception as e:
        # Change back to original directory in case of error
        try:
            os.chdir(original_dir)
        except:
            pass
        print(f"Error validating {doc_path}: {e}")
        return False


def main() -> None:
    """Main function to export and validate all documents."""
    documents = ['SRS', 'SDD', 'SSS', 'IRS', 'IDD', 'SSDD', 'SDP', 'STP', 'STD', 'SPS', 'SVD', 'SUM', 'CPM', 'COM', 'SCOM', 'SIOM', 'SIP', 'FSM', 'DBDD', 'OCD', 'STR', 'STRP']
    
    # Create output directory
    os.makedirs('publications/markdown', exist_ok=True)
    
    # Export all documents
    print("Starting export process...")
    for doc in documents:
        doc_path = f'mil-std-498-doorstop/{doc}'
        output_path = f'publications/markdown/{doc}.yml'
        
        if os.path.exists(doc_path):
            if not export_document(doc_path, output_path):
                print(f"Failed to export {doc}")
                sys.exit(1)
        else:
            print(f"Warning: {doc_path} not found, skipping {doc}")
    
    # Validate all documents
    print("\nStarting validation process...")
    for doc in documents:
        doc_path = f'mil-std-498-doorstop/{doc}'
        
        if os.path.exists(doc_path):
            if not validate_document(doc_path):
                print(f"Failed to validate {doc}")
                sys.exit(1)
        else:
            print(f"Warning: {doc_path} not found, skipping validation for {doc}")
    
    print("\nAll operations completed successfully!")


if __name__ == '__main__':
    main() 