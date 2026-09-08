# macOS Security Audit

A Bash-based security auditing tool that reviews selected macOS security controls without modifying system configuration.

## Features

The security audit checks:

- Application Firewall
- FileVault disk encryption
- System Integrity Protection (SIP)
- Gatekeeper
- Automatic software update checking
- Screen saver password preference
- Remote Login administrator-check requirement

## Finding Types

The audit uses three classifications:

- `[PASS]` - Expected security control is enabled
- `[WARN]` - Configuration may require administrator attention
- `[INFO]` - Informational result or a setting that could not be conclusively determined

## Usage

From the MacOps Toolkit root directory:

```bash
./scripts/security_audit/security_audit.sh
```

## Generate a Report

To display the audit and save a timestamped report:

```bash
./scripts/security_audit/security_audit.sh | tee reports/security_audit_$(date +%Y-%m-%d_%H-%M-%S).txt
```

Generated reports are excluded from version control through the project's `.gitignore` configuration.

## Manual Remote Login Check

Version 1 does not request administrator privileges during the automated audit.

Remote Login can be checked manually with:

```bash
sudo systemsetup -getremotelogin
```

## Skills Demonstrated

- macOS Terminal
- Bash scripting
- macOS security auditing
- Application Firewall inspection
- FileVault inspection
- System Integrity Protection
- Gatekeeper
- Software update configuration
- Shell variables
- Command substitution
- Pipes and `grep`
- Conditional logic
- Multi-state PASS/WARN/INFO reporting
- File permissions
- Git and GitHub
- Technical documentation

## Status

Working initial version. Additional security checks and more detailed findings may be added as the MacOps Toolkit develops.
