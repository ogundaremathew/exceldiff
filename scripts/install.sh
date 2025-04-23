#!/bin/bash

set -e # Exit on error

# Determine OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Map architecture to our naming convention
case "$ARCH" in
    "x86_64")
        ARCH="amd64"
        ;;
    "aarch64" | "arm64")
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Set installation directory
INSTALL_DIR="/usr/local/bin"
if [ ! -w "$INSTALL_DIR" ]; then
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

BINARY_NAME="exceldiff"
DOWNLOAD_URL="https://github.com/ogundaremathew/exceldiff/releases/latest/download/exceldiff-${OS}-${ARCH}"

echo -e "\033[36mInstalling Excel/CSV Diff CLI Tool...\033[0m"
echo "OS: $OS"
echo "Architecture: $ARCH"

# Detect available download tool
if command -v curl &> /dev/null; then
    echo "Downloading using curl..."
    curl -L "$DOWNLOAD_URL" -o "$INSTALL_DIR/$BINARY_NAME"
elif command -v wget &> /dev/null; then
    echo "Downloading using wget..."
    wget -q "$DOWNLOAD_URL" -O "$INSTALL_DIR/$BINARY_NAME"
else
    echo "Error: Neither curl nor wget found. Please install either one."
    exit 1
fi

# Make binary executable
chmod +x "$INSTALL_DIR/$BINARY_NAME"

# Add to PATH if needed
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Adding $INSTALL_DIR to PATH..."
    if [ -f "$HOME/.zshrc" ]; then
        echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.zshrc"
        echo "Please run: source ~/.zshrc"
    elif [ -f "$HOME/.bashrc" ]; then
        echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.bashrc"
        echo "Please run: source ~/.bashrc"
    fi
fi

# Verify installation
if command -v exceldiff &> /dev/null; then
    echo -e "\033[32mInstallation successful!\033[0m"
    echo -e "\033[32mYou can now use 'exceldiff' from any terminal\033[0m"
    echo -e "\033[33mExample: exceldiff file1.xlsx file2.xlsx -k 'Email Address'\033[0m"
else
    echo -e "\033[33mBinary installed to: $INSTALL_DIR/$BINARY_NAME\033[0m"
    echo -e "\033[33mPlease restart your terminal or refresh your PATH\033[0m"
fi