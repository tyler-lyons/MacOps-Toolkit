#!/bin/bash

# =============================================================
# MacOps Toolkit - Backup Automation
# Performs a safe rsync-based backup with validation,
# dry-run support, logging, and exit-status reporting.
# =============================================================


SOURCE="$HOME/IT/HomeLab/Projects/Backup-Test/source/"
DESTINATION="$HOME/IT/HomeLab/Projects/Backup-Test/destination/"
REPORT_DIR="$HOME/IT/macOS/MacOps-Toolkit/reports"


TIMESTAMP=$(date +%Y=%m-%d_%H-%M-%S)
LOG_FILE="$REPORT_DIR/backup_$TIMESTAMP.txt"

DRY_RUN=false


if [ "$1" = "--dry-run" ]; then
    DRY_RUN=true
fi


echo "=================================================" | tee "$LOG_FILE"
echo "MACOPS TOOLKIT - BACKUP AUTOMATION" | tee -a "$LOG_FILE"
echo "=================================================" | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "REPORT INFORMATION" | tee -a "$LOG_FILE"
echo "-------------------------------------------------" | tee -a "$LOG_FILE"
echo "Generated: $(date)" | tee -a "$LOG_FILE"
echo "Source: $SOURCE" | tee -a "$LOG_FILE"
echo "Destination: $DESTINATION" | tee -a "$LOG_FILE"
echo | tee -a "$LOG_FILE"

echo "VALIDATION" | tee -a "$LOG_FILE"
echo "-------------------------------------------------" | tee -a "$LOG_FILE"

if [ -d "$SOURCE" ]; then
    echo "[PASS] Source directory found" | tee -a "$LOG_FILE"
else
    echo "[FAIL] Source directory not found" | tee -a "$LOG_FILE"
    exit 1
fi

if [ -d "$DESTINATION" ]; then
    echo "[PASS] Destination directory found" | tee -a "$LOG_FILE"
else
    echo "[FAIL] Destination directory not found" | tee -a "$LOG_FILE"
    exit 1
fi

if [ -w "$DESTINATION" ]; then
    echo "[PASS] Destination is writable" | tee -a "$LOG_FILE"
else
    echo "[FAIL] Destination is not writable" | tee -a "$LOG_FILE"
    exit 1
fi

echo | tee -a "$LOG_FILE"
echo "BACKUP OPERATION" | tee -a "$LOG_FILE"
echo "-------------------------------------------------" | tee -a "$LOG_FILE"

if [ "$DRY_RUN" = true ]; then
    echo "[INFO] Running backup in dry-run mode" | tee -a "$LOG_FILE"

    rsync -av --dry-run "$SOURCE" "$DESTINATION" | tee -a "$LOG_FILE"

    rsync_status=${PIPESTATUS[0]}
else
    echo "[INFO] Running backup" | tee -a "$LOG_FILE"

    rsync -av "$SOURCE" "$DESTINATION" | tee -a "$LOG_FILE"

    rsync_status=${PIPESTATUS[0]}
fi

echo | tee -a "$LOG_FILE"
echo "BACKUP SUMMARY" | tee -a "$LOG_FILE"
echo "-------------------------------------------------" | tee -a "$LOG_FILE"

if [ "$rsync_status" -eq 0 ]; then
    if [ "$DRY_RUN" = true ]; then
        echo "[PASS] Backup dry run completed successfully" | tee -a "$LOG_FILE"
    else
        echo "[PASS] Backup completed successfully" | tee -a "$LOG_FILE"
    fi
else
    echo "[FAIL] Backup operation returned exit code $rsync_status" | tee -a "$LOG_FILE"
fi

echo "Log File: $LOG_FILE" | tee -a "$LOG_FILE"

echo | tee -a "$LOG_FILE"
echo "=====================================================" | tee -a "$LOG_FILE"
echo "BACKUP AUTOMATION COMPLETE" | tee -a "$LOG_FILE"
echo "=====================================================" | tee -a "$LOG_FILE"
