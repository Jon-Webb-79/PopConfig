#!/usr/bin/zsh
# ================================================================================
# Project Creation Script
# ================================================================================
# - Purpose: This script automates the creation of software development projects
#            for Python, C, C++, and Arduino.
#
# Author: Jonathan A. Webb
# Date: February 25, 2022
# Version: 1.1
# ================================================================================
# ================================================================================
# - Read in the language to be created
script_type='zsh'
language=$1

# Verify that the entry is acceptable
if [[ $language != "Python" ]] && [[ $language != "C" ]] && [[ $language != "C++" ]] && [[ $language != "Arduino" ]]; then
    echo "ERROR: Language must be Python, C, C++, or Arduino."
    exit 1
fi

# --------------------------------------------------------------------------------
# Setup Variables
name='Jonathan A. Webb'
company='Jon Webb'
make_dir='/usr/bin/mkdir'
create_file='/usr/bin/touch'
copy='/usr/bin/cp'
replace='/usr/bin/sed'
dir=`/usr/bin/pwd`

# --------------------------------------------------------------------------------
# Get Project Name from User
echo "Enter the Project Name:"
read project_name

# Define Project Path
path_length="$HOME/Code_Dev/$language/$project_name"

# Verify that the project does not already exist
if [[ -d $path_length ]]; then
    echo "FATAL ERROR: $path_length already exists"
    exit 1
fi

# Create project directory
echo "Creating project directory at $path_length..."
mkdir -p "$path_length"
cd "$path_length"

# Define Config Paths
py_dir="$HOME/.config/py_files/"
c_dir="$HOME/.config/c_files/"
cpp_dir="$HOME/.config/c++_files/"
script_dir="$HOME/.config/${script_type}_scripts/"

# Date variables
day=`date +%d`
month=`date +%B`
year=`date +%Y`

# ================================================================================
# Python Specific Setup
# ================================================================================
if [[ $language == "Python" ]]; then
    echo "Initializing Python project..."

    # Ensure the virtual environment is created in the project directory
    echo "Creating virtual environment in project directory..."
    python3 -m venv .venv

    # Activate virtual environment
    echo "Activating virtual environment..."
    source .venv/bin/activate

    # Install Poetry
    echo "Installing Poetry..."
    pip3 install poetry

    # Configure Poetry to store virtual environments in-project
    poetry config virtualenvs.in-project true

    # Create a new Poetry project
    echo "Creating Poetry project..."
    poetry new "$project_name"

    # - Poetry creates unusual directory strucutre.
    #   Move files to the appropriate structure
    cd $project_name
    mv pyproject.toml ../
    rm README.md 
    mv tests ../
    rm -r $project_name
    cd ..

    # Create Additional Directories
    echo "Setting up directory structure..."
    mkdir -p scripts/{bash,zsh}
    mkdir -p data/test
    mkdir -p docs/requirements
    mkdir -p docs/sphinx/source

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

    # Replace README
    echo "Replacing README.md with README.rst..."
    cp "$py_dir/README.rst" "$path_length/README.rst"

    # Copy Shell Scripts
    echo "Copying shell scripts..."
    cp "$HOME/.config/bash_scripts/run_tests.sh" "$path_length/scripts/bash/run_tests.sh"
    cp "$HOME/.config/bash_scripts/unit_tests.sh" "$path_length/scripts/bash/unit_tests.sh"
    cp "$HOME/.config/zsh_scripts/run_tests.zsh" "$path_length/scripts/zsh/run_tests.zsh"
    cp "$HOME/.config/zsh_scripts/unit_tests.zsh" "$path_length/scripts/zsh/unit_tests.zsh"

    # Update Project Metadata in Files
    echo "Updating metadata in project files..."
    sed -i "s/Day/$day/g" "$path_length/tests/test.py"
    sed -i "s/Month/$month/g" "$path_length/tests/test.py"
    sed -i "s/Year/$year/g" "$path_length/tests/test.py"
    sed -i "s/Name/$name/g" "$path_length/tests/test.py"
    sed -i "s/Company/$company/g" "$path_length/tests/test.py"
    sed -i "s/filename/test/g" "$path_length/tests/test.py"

    sed -i "s/Day/$day/g" "$path_length/conftest.py"
    sed -i "s/Month/$month/g" "$path_length/conftest.py"
    sed -i "s/Year/$year/g" "$path_length/conftest.py"
    sed -i "s/Name/$name/g" "$path_length/conftest.py"
    sed -i "s/Company/$company/g" "$path_length/conftest.py"

    sed -i "s/README.md/README.rst/g" "$path_length/pyproject.toml"
    sed -i "s/Project_Name/$project_name/g" "$path_length/README.rst"
    sed -i "s/pyproject/$project_name/g" "$path_length/pyproject.toml"

    sed -i "s/Day/$day/g" "$path_length/$project_name/main.py"
    sed -i "s/Month/$month/g" "$path_length/$project_name/main.py"
    sed -i "s/Year/$year/g" "$path_length/$project_name/main.py"
    sed -i "s/Name/$name/g" "$path_length/$project_name/main.py"
    sed -i "s/Company/$company/g" "$path_length/$project_name/main.py"
    sed -i "s/filename/main/g" "$path_length/$project_name/main.py"

    # Run the Project Initialization in Tmux
    echo "Running tmux script for project setup..."
    "$script_type" "$script_dir/create_project_tmux.zsh" Python "$project_name"

    echo "Python project setup completed successfully!"
fi

# ================================================================================
# C and C++ Project Setup
# ================================================================================
if [[ $language == "C" ]] || [[ $language == "C++" ]]; then
    echo "Initializing $language project..."

    mkdir -p "$path_length/$project_name"
    mkdir -p scripts/{bash,zsh} data/test docs/requirements docs/doxygen/sphinx_docs
    mkdir -p "$path_length/$project_name"/{test,build,include}

    echo "Copying documentation templates..."
    cp "$c_dir/Doxyfile" "$path_length/docs/doxygen/Doxygen"
    cp "$c_dir/mainpage.dox" "$path_length/docs/doxygen/mainpage.dox"

    echo "Creating virtual environment for documentation..."
    python -m venv "$path_length/docs/doxygen/.venv"
    source "$path_length/docs/doxygen/.venv/bin/activate"
    pip install sphinx-rtd-theme

    echo "Copying source files..."
    if [[ $language == "C" ]]; then
        cp "$c_dir/main.c" "$path_length/$project_name/main.c"
        cp "$c_dir/avrMakefile" "$path_length/$project_name/Makefile"
        cp "$c_dir/CMake1.txt" "$path_length/$project_name/CMakeLists.txt"
    else
        cp "$cpp_dir/main.cpp" "$path_length/$project_name/main.cpp"
        cp "$cpp_dir/CMake1.txt" "$path_length/$project_name/CMakeLists.txt"
    fi

    echo "Updating project metadata in source files..."
    for file in "$path_length/$project_name/main.c" "$path_length/$project_name/main.cpp"; do
        if [[ -f "$file" ]]; then
            sed -i "s/Day/$day/g" "$file"
            sed -i "s/Month/$month/g" "$file"
            sed -i "s/Year/$year/g" "$file"
            sed -i "s/Name/$name/g" "$file"
            sed -i "s/Company/$company/g" "$file"
        fi
    done

    echo "Running tmux script for $language setup..."
    "$script_type" "$script_dir/create_project_tmux.zsh" "$language" "$project_name"

    echo "$language project setup completed successfully!"
fi

# ================================================================================
# Arduino Project Setup
# ================================================================================
if [[ $language == "Arduino" ]]; then
    echo "Initializing Arduino project..."

    mkdir -p "$path_length"
    mkdir -p scripts/{bash,zsh} data/test docs/requirements

    echo "Copying source files..."
    cp "$c_dir/main.ino" "$path_length/$project_name/main.ino"

    echo "Updating project metadata in Arduino sketch..."
    sed -i "s/Day/$day/g" "$path_length/$project_name/main.ino"
    sed -i "s/Month/$month/g" "$path_length/$project_name/main.ino"
    sed -i "s/Year/$year/g" "$path_length/$project_name/main.ino"
    sed -i "s/Name/$name/g" "$path_length/$project_name/main.ino"
    sed -i "s/Company/$company/g" "$path_length/$project_name/main.ino"

    echo "Running tmux script for Arduino setup..."
    "$script_type" "$script_dir/create_project_tmux.zsh" Arduino "$project_name"

    echo "Arduino project setup completed successfully!"
fi

# ================================================================================
# Script Completion Message
# ================================================================================
echo "All setup operations completed successfully! 🚀"
