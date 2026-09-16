# Backup Automation

A Bash-based backup utility that uses `rsync` to perform safe, incremental file backups with path validation, dry-run support, logging, and exit-status reporting.

## Features

The backup automation tool includes:

- Source directory validation
- Destination directory validation
- Writable-destination check
- Dry-run mode
- Incremental file synchronization with `rsync`
- Timestamped log files
- Exit-status checking
- PASS/FAIL reporting
- Non-destructive copy/update behavior

## Safety Design

Version 1 intentionally does not use:

```bash
--delete
```


This prevents the script from removing destination files that no longer exist in the source.

The workflow is designed around:

1. Validate paths
2. Test with dry-run mode
3. Perform the backup
4. Check the `rsync` exit status
5. Log the result
6. Verify source and destination

## Usage

From the Backup Automation directory:

### Dry Run

```bash
./backup_automation.sh --dry-run
```

This shows what `rsync` would tranfer without copying files.

### Real Backup

```bash
./backup_automation.sh
```

## Test Environment

Version 1 uses a controlled test environment:

```text
~/IT/HomeLab/Projects/Backup-Test/
|---source/
|---destination/
```

This allowed the backup proecss to be tested safely before using important data or external storage.

## Logging

Each run creates a timestamped log in:

```text
~/IT/macOS/MacOps-Toolkit/reports/
```

Example:

```text
backup_2026-09-16_13-53-33.tx
```

## Skills Demonstrated

- macOS Terminal
- Bash scripting
- `rsync`
- Incremental backups
- Dry-run testing
- File and directory validation
- Writable-path testing
- Shell variables
- Command substitution
- Conditional logic
- Exit statuses
- `PIPESTATUS`
- Logging with `tee`
- Safe automation design
- Git and GitHub
Technical documentation

## Status

Working initial version tested successfully with synchronized and incremental backup scenarios.
