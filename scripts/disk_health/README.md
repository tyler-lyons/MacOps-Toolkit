# Disk Health

A Bash-based macOS storage diagnostics tool for reviewing physical disk information, SMART status, filesystem utilization, and APFS container capacity without modifying storage.

## Features

The disk health tool checks:

- Physical disk identifier
- SSD model
- Disk capacity
- Storage protocol
- Solid-state status
- Root filesystem utilization
- APFS physical store
- APFS container total space
- APFS container free space
- Storage utilization thresholds

## Health Classifications

The tool uses simple administrative classifications:

- `[PASS]` - Storage status is within the expected range
- `[INFO]` - Storage condition should be reviewed
- `[WARN]` - Storage usage or health may require attention

## Usage

From the MacOps Toolkit root directory:

```bash
./scripts/disk_health/disk_health.sh
```

## Generate a Report

To display the results and save a timestamped report:

```bash
./scripts/disk_health/disk_health.sh | tee reports/disk_health_$(date +%Y-%m-%d_%H-%M-%S).txt
```

Generated reports are exluded from version control through the project's `.gitignore` configuration.

## Storage Thresholds

Version 1 uses these filesystem-utilization thresholds:

- Below 80% -> `[PASS]`
- 80-90% -> `[INFO]`
- 90% or higher -> `[WARN]`

These are administrative thresholds for identifying storage pressure and do not by themselves indicate hardware failure.

## Skills Demonstrated

- macOS Terminal
- Bash scripting
- Storage troubleshooting
- `diskutil`
- APFS architecture
- Physical disk discovery
- SMART status inspection
- Filesystem utilization
- `df`
- `awk`
- Shell variables
- Command substitution
- Conditional logic
- Threshold-based reporting
- File permissions
- Git and GitHub
- Technical documentation

## Status

Working initial version. Additional storage checks and external-drive reporting may be added as the MacOps Toolkit develops.
