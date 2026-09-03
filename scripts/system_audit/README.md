# macOS System Audit

A Bash-based system inventory and health-reporting tool for macOS.

This script is part of the MacOps Toolkit and was developed to practice macOS system administration, shell scripting, hardware and network discovery, troubleshooting, and Git-based project workflows.

## Features

The system audit collects:

- Computer name and hostname
- macOS version and build number
- CPU architecture
- Processor model
- Physical and logical CPU core counts
- Installed memory
- Current user information
- User shell and home directory
- System uptime and load averages
- Root filesystem usage
- Active network interface
- Local IP address

## Usage

From the MacOps Toolkit root directory:

```bash
./scripts/system_audit/system_audit.sh
```

## Generate a Report

To display the audit and save a timestamped report:

```bash
./scripts/system_audit/system_audit.sh | tee reports/system_audit_$(date +%Y-%m-%d_%H-%M-%S).txt
```

Generated reports are excluded from version control through the project's `.gitignore` configuration.

## Skills Demonstrated

- macOS Terminal
- Bash scripting
- System information gathering
- Hardware inventory
- Network interface discovery
- Filesystem analysis
- File permissions
- Shell variables
- Command substitution
- Conditional logic
- Git and GitHub
- Technical documentation

## Status

Working initial version. Additional system-health checks and error handling may be added as the MacOps Toolkit develops.
