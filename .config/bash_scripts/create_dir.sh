#!/usr/bin/env bash
# ================================================================================
# Project Creation Script (Bash Version)
# ================================================================================
# - Purpose: Automates software project setup for Python, C, C++, and Arduino.
#
# Author: Jonathan A. Webb
# Date: February 25, 2022
# Version: 1.2
# ================================================================================
# ================================================================================

script_type='bash'
language=$1

# Verify that the entry is acceptable
if [ "$language" != "Python" ] && [ "$language" != "C" ] && [ "$language" != "C++" ] && [ "$language" != "Arduino" ]; then
    echo "ERROR: Language must be Python, C, C++, or Arduino."
    exit 1
fi

# --------------------------------------------------------------------------------
# Setup Variables
name='Jonathan A. Webb'
company='Jon Webb'
make_dir='/usr/bin/mkdir'
copy='/usr/bin/cp'
replace='/usr/bin/sed'
dir=$(pwd)

# --------------------------------------------------------------------------------
# Get Project Name from User
echo "Enter the Project Name:"
read -r project_name

# Define Project Path
path_length="$HOME/Code_Dev/$language/$project_name"

# Verify that the project does not already exist
if [ -d "$path_length" ]; then
    echo "FATAL ERROR: $path_length already exists"
    exit 1
fi

# Create project directory
echo "Creating project directory at $path_length..."
mkdir -p "$path_length"
cd "$path_length" || exit 1

# Define Config Paths
py_dir="$HOME/.config/py_files/"
c_dir="$HOME/.config/c_files/"
cpp_dir="$HOME/.config/c++_files/"
script_dir="$HOME/.config/${script_type}_scripts/"

# Date variables
day=$(date +%d)
month=$(date +%B)
year=$(date +%Y)

# ================================================================================
# Python Specific Setup
# ================================================================================
if [ "$language" == "Python" ]; then
    echo "Initializing Python project..."

    # Ensure the virtual environment is created in the project directory
    echo "Creating virtual environment in project directory..."
    python3 -m venv .venv

    # Activate virtual environment
    echo "Activating virtual environment..."
    . .venv/bin/activate

    # Install Poetry
    echo "Installing Poetry..."
    pip3 install poetry

    # Configure Poetry to store virtual environments in-project
    poetry config virtualenvs.in-project true

    # Create a new Poetry project
    echo "Creating Poetry project..."
    poetry new "$project_name"

    # Adjust directory structure created by Poetry
    cd "$project_name" || exit 1
    mv pyproject.toml ../
    rm README.md
    mv tests ../
    rm -r "$project_name"
    cd ..

    # Create Additional Directories
    echo "Setting up directory structure..."
    mkdir -p scripts/bash scripts/zsh data/test docs/requirements docs/sphinx/source

    echo "Installing development dependencies..."
    poetry add -G dev pytest flake8 mypy black isort flake8-bandit \
        flake8-bugbear flake8-builtins flake8-comprehensions \
        flake8-implicit-str-concat flake8-print tox pytest-cov pyupgrade pre-commit

    # Copy Config Files
    echo "Copying configuration files..."
    cat "$py_dir/pyproject.toml" >> "$path_length/pyproject.toml"
    cp "$py_dir/.pre-commit-config.yaml" "$path_length/.pre-commit-config.yaml"
    cp "$py_dir/.readthedocs.yaml" "$path_length/.readthedocs.yaml"
    cp "$py_dir/ci_install.txt" "$path_length/ci_install.txt"
    cp "$py_dir/.flake8" "$path_length/.flake8"
    cp "$py_dir/conftest.py" "$path_length/conftest.py"
    cp "$py_dir/.gitignore" "$path_length/.gitignore"
    cp "$py_dir/LICENSE" "$path_length/LICENSE"
    cp "$py_dir/test.py" "$path_length/tests/test.py"
    cp "$py_dir/main.py" "$path_length/$project_name/main.py"
    touch "$path_length/$project_name/__init__.py"
    cp "$py_dir/sphinx_make" "$path_length/docs/sphinx/Makefile"
    cp "$py_dir/conf.py" "$path_length/docs/sphinx/source/conf.py"
    cp "$py_dir/index.rst" "$path_length/docs/sphinx/source/index.rst"
    cp "$py_dir/module.rst" "$path_length/docs/sphinx/source/module.rst"
    cp "$py_dir/sphinx_readme.txt" "$path_length/docs/sphinx/readme.txt"
    cp "$py_dir/Makefile" "$path_length/Makefile"
    cp -r "$py_dir/.github" "$path_length/.github"

    echo "Replacing README.md with README.rst..."
    cp "$py_dir/README.rst" "$path_length/README.rst"

    echo "Running tmux script for project setup..."
    "$script_type" "$script_dir/create_project_tmux.sh" Python "$project_name"

    echo "Python project setup completed successfully!"
fi

# ================================================================================
# C and C++ Project Setup
# ================================================================================
if [ "$language" == "C" ] || [ "$language" == "C++" ]; then
    echo "Initializing $language project..."

    mkdir -p "$path_length/$project_name"
    mkdir -p scripts/bash scripts/zsh data/test docs/requirements docs/doxygen/sphinx_docs
    mkdir -p "$path_length/$project_name"/test "$path_length/$proj

