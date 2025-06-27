#!/usr/bin/env python3
"""
/**
 * This code written by Claude Sonnet 4 (claude-3-5-sonnet-20241022)
 * Generated via Cursor IDE (cursor.sh) with AI assistance
 * Model: Anthropic Claude 3.5 Sonnet
 * Generation timestamp: 2024-06-27
 * Context: Simple doorstop runner script for CI/CD environments
 * 
 * Technical details:
 * - LLM: Claude 3.5 Sonnet (2024-10-22)
 * - IDE: Cursor (cursor.sh)
 * - Generation method: AI-assisted pair programming
 * - Code style: Python with full typing
 * - Dependencies: doorstop, python-frontmatter
 */

Simple doorstop runner script for CI/CD environments.
This script can run doorstop commands directly without needing a virtual environment.
"""

import sys
import subprocess
import os
from typing import List, Optional


def install_doorstop() -> bool:
    """Install doorstop and dependencies if not available."""
    try:
        import doorstop
        print("Doorstop already available")
        return True
    except ImportError:
        print("Installing doorstop and dependencies...")
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", "doorstop", "python-frontmatter"])
            return True
        except subprocess.CalledProcessError:
            print("Failed to install doorstop")
            return False


def run_doorstop_command(args: List[str]) -> int:
    """Run a doorstop command."""
    try:
        # Try to import doorstop
        import doorstop
        from doorstop import main
        
        # Set up sys.argv for doorstop
        sys.argv = ["doorstop"] + args
        
        # Run doorstop main function
        return main()
    except ImportError:
        # Fallback: try to run doorstop as a module
        try:
            return subprocess.call([sys.executable, "-m", "doorstop"] + args)
        except subprocess.CalledProcessError as e:
            print(f"Failed to run doorstop: {e}")
            return 1


def main() -> int:
    """Main function."""
    if len(sys.argv) < 2:
        print("Usage: python run_doorstop.py <doorstop_command> [args...]")
        print("Example: python run_doorstop.py export SRS")
        return 1
    
    # Install doorstop if needed
    if not install_doorstop():
        return 1
    
    # Run the doorstop command
    doorstop_args = sys.argv[1:]
    return run_doorstop_command(doorstop_args)


if __name__ == "__main__":
    sys.exit(main()) 