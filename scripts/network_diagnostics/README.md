# Network Diagnostics

A Bash-based macOS network troubleshooting tool for checking local network configuration, gateway connectivity, and DNS resolution

## Features

The diagnostic tool checks:

- Active network interface
- Local IP address
- Default gateway
- Configured DNS servers
- Gateway reachability
- Internet IP connectivity
- DNS name resolution
- Overall network configuration status

## Usage

From the MacOps Toolkit root directory:

```bash
./scripts/network_diagnostics/network_diagnostics.sh

## Generate a Report

To display the diagnostics and save a timestamped report:

```bash
./scripts/network_diagnostics/network_diagnostics.sh | tee reports/network_diagnostics_$(date +%Y-%m-%d_%H-%M-%S).txt
```

Generated reports are excluded from version control through the project's `.gitignore` configuration.

## Troubleshooting Logic

The tool tests network connectivity in stages:

1. Detect the active network interface and IP configuration.
2. Identify the default gateway.
3. Test connectivity to the local gateway.
4. Test external connectivity using an IP address.
5. Test DNS name resolution separately.

This helps distinguish between local network, internet connectivity, and DNS-related problems.

## Skills Demonstrated

- macOS Terminal
- Bash scripting
- Network troubleshooting
- IP addressing
- Default gateway discovery
- DNS inspection and resolution
- Ping testing
- Command pipelines
- Shell variables
- Conditional logic
- Exit-status-based troubleshooting
- Git and GitHub
- Technical documentation

## Status

Working initial version. Additional diagnostics and more detailed failure reporting may be added as the MacOps Toolkit develops.

