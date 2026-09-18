# Full Health Check

A Bash-based orchestration tool that runs the primary MacOps diagnostic utilities in sequence and generates one consolidated system health report.

## Included Diagnostics

The Full Health Check runs:

- System Audit
- Network Diagnostics
- Security Audit
- Disk Health

Backup Automation is intentionally excluded because it performs file-copy operations rather than read-only diagnostics.

## Usage

From the MacOps Toolkit root directory:

```bash
.scripts/full_health_check/full_health_check.sh
```

## Output

The tool creates a timestamped consolidated report in:

```text
~/IT/macOS/MacOps-Toolkit/reports/
```

Example:

```text
full_health_check_2026-09-17_16-02-34.txt
```

Generated reports are excluded from version control through the project's `.gitignore`.

## Workflow

The Full Health Check:

1. Validates that each diagnostic tool is executable
2. Runs each tool sequentially
3. Captures each tool's output
4. Records the exit status
5. Adds PASS/WARN results
6. Writes everything into one consolidated report

## Skills Demonstrated

- Bash functions
- Script orchestration
- Executable-file validation
- Exit-status handling
- `PIPESTATUS`
- Logging with `tee`
- Modular script design
- macOS system administration
- Read-only diagnostic workflows
- Git and GitHub
- Technical documentation

## Status

Working initial version that consolidates the primary MacOps diagnostic tools into a single system health workflow.
