# Excel/CSV Diff CLI Tool

A powerful command-line tool for comparing Excel (.xlsx) and CSV files. Perfect for data analysts, QA engineers, and anyone who needs to compare large datasets efficiently.

## Features

- Compare Excel (.xlsx) and CSV files
- Key-based or index-based comparison
- Support for multiple sheets in Excel files
- Case-sensitive/insensitive comparison options
- Colored console output for easy reading
- Comprehensive JSON output for programmatic use
- Generate separate files for differences and similarities
- Cross-platform support (Windows, macOS, Linux)
- ARM64 and AMD64 architecture support

## Installation

### macOS / Linux

Install with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/ogundaremathew/exceldiff/main/scripts/install.sh | bash
```

Or with wget:

```bash
wget -qO- https://raw.githubusercontent.com/ogundaremathew/exceldiff/main/scripts/install.sh | bash
```

### Windows

Install using PowerShell (run as administrator):

```powershell
irm https://raw.githubusercontent.com/ogundaremathew/exceldiff/main/scripts/install.ps1 | iex
```

The installer will automatically detect your system architecture (AMD64/ARM64) and install the appropriate version.

## Usage

Basic comparison:
```bash
exceldiff file1.xlsx file2.xlsx
```

### Key-based Comparison

Compare files using specific columns as keys:
```bash
exceldiff file1.xlsx file2.xlsx -k "Email Address,ID"
```

### Sheet Selection

Specify sheets for Excel files:
```bash
exceldiff file1.xlsx file2.xlsx -k "ID" --sheet1 "Sheet1" --sheet2 "Data"
```

### Ignore Columns

Ignore specific columns during comparison:
```bash
exceldiff file1.xlsx file2.xlsx -k "ID" -i "LastUpdated,Timestamp"
```

### Case Sensitivity

Enable case-sensitive comparison:
```bash
exceldiff file1.xlsx file2.xlsx -k "ID" --case-sensitive
```

### Include Similar Rows

Show similar rows in the output:
```bash
exceldiff file1.xlsx file2.xlsx -k "ID" --include-similar
```

### Limit Rows

Limit the number of rows processed (useful for testing):
```bash
exceldiff file1.xlsx file2.xlsx -k "ID" --limit 100
```

## Output Files

The tool generates three types of output files:

1. `comparison.json` - Comprehensive comparison results in JSON format
2. `differences_mm-dd-yy-hh-mm-ss.(xlsx/csv)` - All differences found between the files
3. `similarities_mm-dd-yy-hh-mm-ss.(xlsx/csv)` - All matching rows between the files

The output format (xlsx/csv) matches the input file format.

## Command Line Options

```
Flags:
      --case-sensitive           Perform case-sensitive comparisons
  -h, --help                    Show help message
  -i, --ignore-columns strings  Columns to ignore (e.g., "LastUpdated,Timestamp")
      --include-similar         Include similar rows in output
  -k, --key-columns strings     Key columns for matching rows
      --limit int              Limit rows processed
  -o, --output string          Path for JSON output file
  -1, --sheet1 string          Sheet name for first Excel file
  -2, --sheet2 string          Sheet name for second Excel file
```

## Examples

### Compare Customer Data

Compare customer databases using email as the key:
```bash
exceldiff customers_old.xlsx customers_new.xlsx -k "Email Address" --include-similar
```

### Compare Financial Data

Compare financial reports ignoring timestamp columns:
```bash
exceldiff report_2024.xlsx report_2025.xlsx -k "Transaction ID" -i "Timestamp,Last Modified"
```

### Compare Multi-sheet Excel Files

Compare specific sheets in Excel files:
```bash
exceldiff q1_data.xlsx q2_data.xlsx -k "Order ID" --sheet1 "Q1 Sales" --sheet2 "Q2 Sales"
```

## System Requirements

- Windows, macOS, or Linux
- 64-bit operating system (AMD64 or ARM64)
- No additional dependencies required (self-contained binary)

## Development

### Building from Source

Clone the repository and build:
```bash
git clone https://github.com/ogundaremathew/exceldiff.git
cd exceldiff/src/exceldiff
go build
```

### Creating a Release

Prerequisites:
- GitHub CLI (`gh`) installed and authenticated
- Go 1.16 or later

To create a new release:

1. Make sure all your changes are committed and pushed
2. Run the release script:
   ```bash
   ./scripts/release.sh v1.0.0
   ```
   Replace v1.0.0 with your version number

The script will:
- Build binaries for all supported platforms (Windows, macOS, Linux) and architectures (AMD64, ARM64)
- Generate SHA256 checksums
- Create a GitHub release with all the binaries

## Support

For issues and feature requests, please file an issue on GitHub.

## License

MIT License - feel free to use in your own projects.