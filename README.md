# MacOps Toolkit

A modular macOS administration, diagnostics, security, storage, and automation toolkit developed as part of hands-on IT training.

The project was designed to strengthen practical skills in macOS Terminal administration, Bash scripting, troubleshooting, networking, security auditing, storage analysis, backup automation, Git, GitHub, and technical documentation.

## Toolkit Modules

### System Audit

Collects macOS system and hardware information including:

- Computer name and hostname
- macOS version and build
- CPU architecture and processor
- Physical and logical CPU cores
- Installed memory
- User and shell information
- System uptime
- Storage usage
- Active network interface
- Local IP address

Run:

```bash
./scripts/system_audit/system_audit.sh
```

---

### Network Diagnostics

Performs structured network troubleshooting including:

- Active interface detection
- Local IP discovery
- Default gateway detection
- DNS configuration
- Gateway reachability
- Internet IP connectivity
- DNS resolution
- PASS/FAIL diagnostic results

Run:

```bash
./scripts/network_diagnostics/network_diagnostics.sh
```

---

### Security Audit

Reviews selected macOS security controls without modifying system configuration.

Checks include:

- Application Firewall
- FileVault
- System Integrity Protection
- Gatekeeper
- Automatic update checking
- Screen-lock preferences
- Remote Login administrator-check requirement

Findings use:

- `[PASS]`
- `[WARN]`
- `[INFO]`

Run:

```bash
./scripts/security_audit/security_audit.sh
```

---

### Disk Health

Reviews internal storage health and utilization including:

- Physical disk discovery
- SSD model and capacity
- Storage protocol
- SMART health
- Filesystem utilization
- APFS physical store
- APFS container capacity
- Storage threshold reporting

Run:

```bash
./scripts/disk_health/disk_health.sh
```

---

### Backup Automation

Provides a controlled `rsync`-based backup workflow with:

- Source validation
- Destination validation
- Writable-path checking
- Dry-run support
- Incremental synchronization
- Exit-status checking
- Timestamped logs
- PASS/FAIL reporting

Dry run:

```bash
./scripts/backup_automation/backup_automation.sh --dry-run
```

Real backup:

```bash
./scripts/backup_automation/backup_automation.sh
```

Version 1 intentionally does not use `rsync --delete` in order to reduce destructive risk.

---

### Full Health Check

Runs the primary read-only diagnostic tools in sequence and creates one consolidated health report.

Included:

- System Audit
- Network Diagnostics
- Security Audit
- Disk Health

Run:

```bash
./scripts/full_health_check/full_health_check.sh
```

Backup Automation is intentionally kept separate because it performs file-copy operations rather than read-only diagnostics.

## Project Structure

```text
MacOps-Toolkit/
├── .gitignore
├── README.md
├── documentation/
├── reports/
├── scripts/
│   ├── backup_automation/
│   │   ├── backup_automation.sh
│   │   └── README.md
│   ├── disk_health/
│   │   ├── disk_health.sh
│   │   └── README.md
│   ├── full_health_check/
│   │   ├── full_health_check.sh
│   │   └── README.md
│   ├── network_diagnostics/
│   │   ├── network_diagnostics.sh
│  │  └─README.md
│  ├─security_audit/
│  │  ├─security_audit.sh
│  │  └─README.md
│  └─system_audit/
│      ├─system_audit.sh
│      └─README.md
└─ tests/
```

## Reports

Diagnostic tools can generate timestamped reports inside:

```text
reports/
```

Examples:

```text
system_audit_YYYY-MM-DD_HH-MM-SS.txt
network_diagnostics_YYYY-MM-DD_HH-MM-SS.txt
security_audit_YYYY-MM-DD_HH-MM-SS.txt
disk_health_YYYY-MM-DD_HH-MM-SS.txt
backup_YYYY-MM-DD_HH-MM-SS.txt
full_heath_check_YYYY-MM-DD_HH-MM-SS.txt
```

Generated reports are excluded from version control through `.gitignore` so machine-specific output is not automatically published to GitHub.

## Development Workflow

This project follows a repeatable workflow:

```text
Investigate
    ꜜ
Understand
    ꜜ
Build
    ꜜ
Syntax Check
    ꜜ
Test
    ꜜ
Troubleshoot
    ꜜ
Document
    ꜜ
Review Git Changes
    ꜜ
Commit
    ꜜ
Push to GitHub
```

## Safety Design

This toolkit was intentionally designed around several safety principles:

- Diagnostic scripts are read-only
- Security auditing does not modify settings
- Disk Health does not repare, erase, mount, or format storage
- Backup Automation supports dry-run testing
- Backup Automation does not use `rsync --delete`
- Generated reports remain outside version control
- Administrator privileges are avoided unless a manual check specifically requires them

## Skills Demonstrated

### macOS Administration

- Terminal navigation
- Files and directories
- Permissions
- System information gathering
- Storage inspection
- Security configuration inspection

### Bash

- Variables
- Command substitution
- Functions
- `if / elif / else`
- File and directory tests
- Pipes
- `grep`
- `awk`
- Exit statuses
- `PIPESTATUS`
- Threshold-based logic
- Script orchestration

### Networking

- Interface discovery
- IP addressing
- Default gateways
- DNS configuration
- Connectivity testing
- Troubleshooting isolation

### Security

- Application Firewall
- FileVault
- System Integrity Protection
- Gatekeeper
- Software update configuration
- Read-only security auditing

### Storage & Backup

- `diskutil`
- APFS architecture
- SMART status
- Filesystem utilization
- `df`
- `rsync`
- Incremental backups
- Dry-run testing
- Backup logging

### Version Control

- Git repositories
- Staging
- Commits
- Diffs
- Restore operations
- Branch tracking
- GitHub remotes
- SSH authentication
- Technical documentation

## Project Milestones

- [x] IT workspace and Terminal foundation
- [x] Git fundamentals
- [x] GitHub and SSH configuration
- [x] MacOps Toolkit repository
- [x] System Audit
- [x] Network Diagnostics
- [x] Security Audit
- [x] Disk Health
- [x] Backup Automation
- [x] Full Health Check

## Status

**Version 1 complete.**

The MacOps Toolkit currently provides five dedicated administration and troubleshooting utilities plus a consolidated Full Health Check workflow.
Future versions may include additional diagnostics, enhanced error handling, configurable paths, external-drive reporting, expanded security checks, automated testing, and additional reporting formats.
