"""
This code written by Claude Sonnet 4 (claude-3-5-sonnet-20241022)
Generated via Cursor IDE (cursor.sh) with AI assistance
Model: Anthropic Claude 3.5 Sonnet
Generation timestamp: 2024-06-26
Context: Python script to convert MIL-STD-498 markdown requirements to doorstop format

Technical details:
- LLM: Claude 3.5 Sonnet (2024-10-22)
- IDE: Cursor (cursor.sh)
- Generation method: AI-assisted pair programming
- Code style: Python with full mypy typing and numpy style documentation
- Dependencies: re, os, pathlib, frontmatter

Convert MIL-STD-498 markdown requirements to doorstop format.

This script reads markdown files from mil-std-498-requirements/ and converts
each requirement to a doorstop markdown item file with proper traceability links.
"""

import re
import os
from pathlib import Path
from typing import Dict, List, Tuple, Optional, Set
import frontmatter


def extract_requirements_from_markdown(markdown_file: Path) -> List[Dict[str, str]]:
    """
    Extract requirements from a markdown file.
    
    Parameters
    ----------
    markdown_file : Path
        Path to the markdown file containing requirements
        
    Returns
    -------
    List[Dict[str, str]]
        List of requirement dictionaries with uid, title, and text
    """
    requirements = []
    
    with open(markdown_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Pattern to match requirements like "**SRS-001: Software Identification**"
    pattern = r'\*\*([A-Z]+-\d+):\s*([^*]+)\*\*'
    matches = re.finditer(pattern, content)
    
    for match in matches:
        uid = match.group(1)
        title = match.group(2).strip()
        
        # Find the text content for this requirement
        # Look for the next requirement or end of content
        start_pos = match.end()
        next_match = re.search(pattern, content[start_pos:])
        
        if next_match:
            end_pos = start_pos + next_match.start()
        else:
            end_pos = len(content)
        
        # Extract the requirement text
        requirement_text = content[start_pos:end_pos].strip()
        
        # Clean up the text (remove leading/trailing whitespace, newlines)
        requirement_text = re.sub(r'^\s*[-*]\s*', '', requirement_text, flags=re.MULTILINE)
        requirement_text = requirement_text.strip()
        
        requirements.append({
            'uid': uid,
            'title': title,
            'text': requirement_text
        })
    
    return requirements


def extract_traceability_matrix(markdown_file: Path) -> Dict[str, List[str]]:
    """
    Extract traceability matrix from markdown file.
    
    Parameters
    ----------
    markdown_file : Path
        Path to the markdown file containing traceability matrix
        
    Returns
    -------
    Dict[str, List[str]]
        Dictionary mapping requirement UIDs to their parent requirements
    """
    traceability = {}
    
    with open(markdown_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Look for traceability matrix section
    matrix_pattern = r'### 5\.1 Traceability Matrix.*?\|.*?\|.*?\|.*?\|.*?\|(.*?)(?=###|\Z)'
    matrix_match = re.search(matrix_pattern, content, re.DOTALL)
    
    if matrix_match:
        matrix_content = matrix_match.group(1)
        
        # Parse table rows
        row_pattern = r'\|([^|]+)\|([^|]+)\|([^|]+)\|([^|]+)\|'
        rows = re.findall(row_pattern, matrix_content)
        
        for row in rows:
            req_id = row[0].strip()
            parent_req = row[1].strip()
            
            if req_id and parent_req != '-' and parent_req:
                traceability[req_id] = [parent_req]
    
    return traceability


def create_doorstop_item_file(
    doc_prefix: str,
    requirement: Dict[str, str],
    parent_links: List[str],
    output_dir: Path
) -> None:
    """
    Create a doorstop markdown item file.
    
    Parameters
    ----------
    doc_prefix : str
        Document prefix (e.g., 'SRS', 'SDD')
    requirement : Dict[str, str]
        Requirement dictionary with uid, title, and text
    parent_links : List[str]
        List of parent requirement UIDs
    output_dir : Path
        Output directory for the doorstop item file
    """
    uid = requirement['uid']
    title = requirement['title']
    text = requirement['text']
    
    # Create the doorstop item content
    item_content = f"""/**
 * This code written by Claude Sonnet 4 (claude-3-5-sonnet-20241022)
 * Generated via Cursor IDE (cursor.sh) with AI assistance
 * Model: Anthropic Claude 3.5 Sonnet
 * Generation timestamp: 2024-06-26
 * Context: Doorstop item for {uid}: {title}
 * 
 * Technical details:
 * - LLM: Claude 3.5 Sonnet (2024-10-22)
 * - IDE: Cursor (cursor.sh)
 * - Generation method: AI-assisted pair programming
 * - Code style: Markdown for Doorstop item
 * - Dependencies: Doorstop 3.0.2
 */
---
uid: {uid}
title: {title}"""
    
    if parent_links:
        item_content += f"\nlinks:\n"
        for link in parent_links:
            item_content += f"  - {link}\n"
    
    item_content += f"""---
{text}
"""
    
    # Write the file
    output_file = output_dir / f"{uid}.md"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(item_content)


def process_document(doc_prefix: str, source_file: Path, output_dir: Path) -> None:
    """
    Process a single document and convert all requirements to doorstop format.
    
    Parameters
    ----------
    doc_prefix : str
        Document prefix (e.g., 'SRS', 'SDD')
    source_file : Path
        Source markdown file path
    output_dir : Path
        Output directory for doorstop items
    """
    print(f"Processing {doc_prefix} from {source_file}")
    
    # Extract requirements
    requirements = extract_requirements_from_markdown(source_file)
    print(f"  Found {len(requirements)} requirements")
    
    # Extract traceability matrix
    traceability = extract_traceability_matrix(source_file)
    print(f"  Found {len(traceability)} traceability links")
    
    # Create output directory if it doesn't exist
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Process each requirement
    for requirement in requirements:
        uid = requirement['uid']
        parent_links = traceability.get(uid, [])
        
        create_doorstop_item_file(doc_prefix, requirement, parent_links, output_dir)
        print(f"  Created {uid}.md")
    
    print(f"Completed {doc_prefix}")


def main() -> None:
    """Main function to process all MIL-STD-498 documents."""
    # Define document mappings
    documents = [
        ('SRS', 'mil-std-498-requirements/SRS.md', 'mil-std-498-doorstop/SRS'),
        ('SDD', 'mil-std-498-requirements/SDD.md', 'mil-std-498-doorstop/SDD'),
        ('IRS', 'mil-std-498-requirements/IRS.md', 'mil-std-498-doorstop/IRS'),
        ('IDD', 'mil-std-498-requirements/IDD.md', 'mil-std-498-doorstop/IDD'),
        ('SSS', 'mil-std-498-requirements/SSS.md', 'mil-std-498-doorstop/SSS'),
        ('SSDD', 'mil-std-498-requirements/SSDD.md', 'mil-std-498-doorstop/SSDD'),
        ('SDP', 'mil-std-498-requirements/SDP.md', 'mil-std-498-doorstop/SDP'),
        ('STP', 'mil-std-498-requirements/STP.md', 'mil-std-498-doorstop/STP'),
        ('STD', 'mil-std-498-requirements/STD.md', 'mil-std-498-doorstop/STD'),
        ('SPS', 'mil-std-498-requirements/SPS.md', 'mil-std-498-doorstop/SPS'),
        ('SVD', 'mil-std-498-requirements/SVD.md', 'mil-std-498-doorstop/SVD'),
        ('SUM', 'mil-std-498-requirements/SUM.md', 'mil-std-498-doorstop/SUM'),
        ('CPM', 'mil-std-498-requirements/CPM.md', 'mil-std-498-doorstop/CPM'),
        ('COM', 'mil-std-498-requirements/COM.md', 'mil-std-498-doorstop/COM'),
        ('SCOM', 'mil-std-498-requirements/SCOM.md', 'mil-std-498-doorstop/SCOM'),
        ('SIOM', 'mil-std-498-requirements/SIOM.md', 'mil-std-498-doorstop/SIOM'),
        ('SIP', 'mil-std-498-requirements/SIP.md', 'mil-std-498-doorstop/SIP'),
        ('FSM', 'mil-std-498-requirements/FSM.md', 'mil-std-498-doorstop/FSM'),
        ('DBDD', 'mil-std-498-requirements/DBDD.md', 'mil-std-498-doorstop/DBDD'),
        ('OCD', 'mil-std-498-requirements/OCD.md', 'mil-std-498-doorstop/OCD'),
        ('STR', 'mil-std-498-requirements/STR.md', 'mil-std-498-doorstop/STR'),
        ('STRP', 'mil-std-498-requirements/STRP.md', 'mil-std-498-doorstop/STRP'),
    ]
    
    print("Starting conversion of MIL-STD-498 requirements to doorstop format...")
    
    for doc_prefix, source_file, output_dir in documents:
        source_path = Path(source_file)
        output_path = Path(output_dir)
        
        if source_path.exists():
            process_document(doc_prefix, source_path, output_path)
        else:
            print(f"Warning: Source file {source_file} not found, skipping {doc_prefix}")
    
    print("Conversion completed!")


if __name__ == "__main__":
    main() 