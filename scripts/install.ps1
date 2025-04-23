# Installation script for Excel/CSV Diff CLI Tool
#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

# Determine system architecture
$arch = if ([System.Environment]::Is64BitOperatingSystem) {
    if ([System.Runtime.InteropServices.RuntimeInformation]::ProcessArchitecture -eq [System.Runtime.InteropServices.Architecture]::Arm64) {
        "arm64"
    } else {
        "amd64"
    }
} else {
    Write-Error "32-bit systems are not supported"
    exit 1
}

# Define installation paths
$installDir = "$env:ProgramFiles\exceldiff"
$exePath = "$installDir\exceldiff.exe"
$binUrl = "https://github.com/ogundaremathew/exceldiff/releases/latest/download/exceldiff-windows-$arch.exe"

Write-Host "Installing Excel/CSV Diff CLI Tool..." -ForegroundColor Cyan
Write-Host "Architecture: $arch"

# Remove existing installation if present
if (Test-Path $installDir) {
    Write-Host "Removing existing installation..." -ForegroundColor Yellow
    Remove-Item -Path $installDir -Recurse -Force
}

# Create installation directory
Write-Host "Creating installation directory..."
New-Item -ItemType Directory -Path $installDir -Force | Out-Null

try {
    # Download the binary
    Write-Host "Downloading binary for $arch architecture..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $binUrl -OutFile $exePath -UseBasicParsing

    # Add to System PATH if not already present
    $systemPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($systemPath -notlike "*$installDir*") {
        Write-Host "Adding to System PATH..." -ForegroundColor Yellow
        $newPath = "$systemPath;$installDir"
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        $env:Path = "$env:Path;$installDir"
    }

    # Test the installation
    $env:Path = "$env:Path;$installDir"
    if (Get-Command exceldiff -ErrorAction SilentlyContinue) {
        Write-Host "`nInstallation successful!" -ForegroundColor Green
        Write-Host "You can now use 'exceldiff' from any terminal" -ForegroundColor Green
        Write-Host "Example: exceldiff file1.xlsx file2.xlsx -k 'Email Address'" -ForegroundColor Yellow
    } else {
        Write-Host "`nBinary installed to: $exePath" -ForegroundColor Yellow
        Write-Host "Please restart your terminal to use exceldiff" -ForegroundColor Yellow
    }
} catch {
    Write-Error "Installation failed: $_"
    if (Test-Path $installDir) {
        Remove-Item -Path $installDir -Recurse -Force
    }
    exit 1
}