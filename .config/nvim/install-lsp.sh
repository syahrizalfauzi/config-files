#!/bin/bash

# Define an array of npm packages to install globally
npmPackages=(
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    bash-language-server 
    typescript typescript-language-server
    intelephense
    @angular/language-server
)

# Check if npm is installed
if ! command -v npm &> /dev/null
then
    echo "npm could not be found, please install Node.js and npm."
    exit 1
fi

# Loop through each package in the array and install it globally
for package in "${npmPackages[@]}"; do
    echo "Installing $package globally..."
    npm i -g "$package"
    
    # Check if the installation was successful
    if [ $? -eq 0 ]; then
        echo "$package installed successfully!"
    else
        echo "There was an error installing $package."
        exit 1
    fi
done

rustup component add rustfmt
