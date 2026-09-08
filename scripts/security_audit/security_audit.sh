#!/bin/bash

# ============================================================
# MacOps Toolkit - macOS Security Audit
# Reviews selected macOS security controls and reports their
# current state without modifying system configuration.
# ============================================================

echo "=================================================="
echo "MACOPS TOOLKIT - SECURITY AUDIT"
echo "=================================================="
echo

echo "REPORT INFORMATION"
echo "__________________________________________________"
echo "Generated: $(date)"
echo

echo "SECURITY CONTROLS"
echo "__________________________________________________"

firewall_status=$(/usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate 2>/dev/null)

if echo "$firewall_status" | grep -q "State = 1"; then
    echo "[PASS] Application Firewall enabled"
else
   echo "[WARN] Application Firewall not enabled"
fi

filevault_status=$(fdesetup status 2>/dev/null)

if echo "$filevault_status" | grep -q "FileVault is On"; then
    echo "[PASS] FileVault enabled"
else
    echo "[WARN] FileVault not enabled"
fi

sip_status=$(csrutil status 2>/dev/null)

if echo "$sip_status" | grep -q "enabled"; then
    echo "[PASS] System Integrity Protection enabled"
else
    echo "[WARN} System Integrity Protection not enabled"
fi

gatekeeper_status=$(spctl --status 2>/dev/null)

if echo "$gatekeeper_status" | grep -q "assessments enabled"; then
    echo "[PASS] Gatekeeper enabled"
else
    echo "[WARN] Gatekeeper not enabled"
fi

update_status=$(softwareupdate --schedule 2>/dev/null)

if echo "$update_status" | grep -q "on"; then
    echo "[PASS] Automatic update checking enabled"
else
    echo "[WARN] Automatic update checking not enabled"
fi

screen_lock=$(defaults read com.apple.screensaver askForPassword 2>/dev/null)

if [ "$screen_lock" = "1" ]; then
    echo "[PASS] Screen saver password requirement enabled"
elif [ "$screen_lock" = "0" ]; then
    echo "[WARN] Screen saver password requirement disabled"
else
    echo "[INFO] Screen saver password preference not determined"
fi

echo "[INFO] Remote Login status requires an administrator check"

echo
echo "SECURITY SUMMARY"
echo "__________________________________________________"
echo "Review any [WARN] or [INFO] findings above."
echo

echo "========================================================="
echo "SECURITY AUDIT COMPLETE"
echo "========================================================="
