#!/bin/bash

# ===============================================================
# MacOps Toolkit - Full Health Check
# Runs the primary MacOps diagnostic tools in sequence and
# products a consoldated health report.
# ===============================================================

ROOT_DIR="$HOME/IT/macOS/MacOps-Toolkit"
REPORT_DIR="$ROOT_DIR/reports"

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
REPORT_FILE="$REPORT_DIR/full_health_check_$TIMESTAMP.txt"

echo "==================================================" | tee "$REPORT_FILE"
echo "MACOPS TOOLKIT - FULL HEALTH CHECK" | tee -a "$REPORT_FILE"
echo "==================================================" | tee -a "$REPORT_FILE"
echo | tee -a "$REPORT_FILE"

echo "Generated: $(date)" | tee -a "$REPORT_FILE"
echo | tee -a "$REPORT_FILE"

run_tool() {
    tool_name="$1"
    tool_path="$2"

    echo "===================================================" | tee -a "$REPORT_FILE"
    echo "$tool_name" | tee -a "$REPORT_FILE"
    echo "===================================================" | tee -a "$REPORT_FILE"

    if [ -x "$tool_path" ]; then
        "$tool_path" | tee -a "$REPORT_FILE"
        tool_status=${PIPESTATUS[0]}

        if [ "$tool_status" -eq 0 ]; then
            echo "[PASS] $tool_name completed successfully" | tee -a "$REPORT_FILE"
        else
            echo "[WARN] $tool_name returned exit code $tool_status" | tee -a "$REPORT_FILE"
        fi
    else
        echo "[WARN] Tool not found or not executable: $tool_path" | tee -a "$REPORT_FILE"
    fi

    echo | tee -a "$REPORT_FILE"
}

run_tool "SYSTEM AUDIT" \
"$ROOT_DIR/scripts/system_audit/system_audit.sh"

run_tool "NETWORK DIAGNOSTICS" \
"$ROOT_DIR/scripts/network_diagnostics/network_diagnostics.sh"

run_tool "SECURITY AUDIT" \
"$ROOT_DIR/scripts/security_audit/security_audit.sh"

run_tool "DISK HEALTH" \
"$ROOT_DIR/scripts/disk_health/disk_health.sh"

echo "==================================================" | tee -a "$REPORT_FILE"
echo "FULL HEALTH CHECK SUMMARY" | tee -a "$REPORT_FILE"
echo "==================================================" | tee -a "$REPORT_FILE"

echo "[INFO] Backup Automation is maintained as a separate action-based tool." | tee -a "$REPORT_FILE"
echo "[INFO] Full Health Check completed." | tee -a "$REPORT_FILE"
echo "Report File: $REPORT_FILE" | tee -a "$REPORT_FILE"

echo
echo "=================================================="
echo "FULL HEALTH CHECK COMPLETE"
echo "=================================================="
