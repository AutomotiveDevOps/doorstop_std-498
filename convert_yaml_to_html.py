#!/usr/bin/env python3
"""
Convert YAML files to HTML for MIL-STD-498 documentation.

This script converts doorstop YAML exports to HTML files.

Generated via Cursor IDE with AI assistance
"""

import yaml
import sys
import os
import subprocess
from typing import Dict, List, Any


def convert_yaml_to_markdown(yaml_file: str, markdown_file: str, doc_name: str) -> None:
    """Convert YAML file to markdown format."""
    try:
        with open(yaml_file, 'r') as f:
            data = yaml.safe_load(f)
        
        with open(markdown_file, 'w') as f:
            f.write(f'# {doc_name} Requirements\n\n')
            if 'requirements' in data:
                for req in data['requirements']:
                    f.write(f'## {req.get("uid", "Unknown")}\n\n')
                    f.write(f'**Title**: {req.get("title", "No title")}\n\n')
                    f.write(f'**Text**: {req.get("text", "No text")}\n\n')
                    if req.get('parent'):
                        f.write(f'**Parent**: {req["parent"]}\n\n')
                    f.write('---\n\n')
    except Exception as e:
        print(f'Error processing {yaml_file}: {e}')
        sys.exit(1)


def convert_markdown_to_html(markdown_file: str, html_file: str, css_file: str) -> None:
    """Convert markdown file to HTML using pandoc."""
    try:
        cmd = [
            'pandoc',
            markdown_file,
            '--from', 'markdown',
            '--to', 'html',
            '--standalone',
            '--css', css_file,
            '--output', html_file
        ]
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f'Error converting {markdown_file} to HTML: {e}')
        sys.exit(1)


def main() -> None:
    """Main function to convert all YAML files to HTML."""
    documents = ['SRS', 'SDD', 'SSS', 'IRS', 'IDD', 'SSDD', 'SDP', 'STP', 'STD', 'SPS', 'SVD', 'SUM', 'CPM', 'COM', 'SCOM', 'SIOM', 'SIP', 'FSM', 'DBDD', 'OCD', 'STR', 'STRP']
    
    # Create HTML directory
    os.makedirs('publications/html', exist_ok=True)
    
    for doc in documents:
        yaml_file = f'publications/markdown/{doc}.yml'
        markdown_file = f'publications/markdown/{doc}.md'
        html_file = f'publications/html/{doc}.html'
        css_file = 'template/doorstop.css'
        
        if os.path.exists(yaml_file):
            print(f'Converting {doc}.yml to HTML...')
            convert_yaml_to_markdown(yaml_file, markdown_file, doc)
            convert_markdown_to_html(markdown_file, html_file, css_file)
            print(f'Successfully converted {doc}.yml to {html_file}')
        else:
            print(f'Warning: {yaml_file} not found, skipping {doc}')


if __name__ == '__main__':
    main() 