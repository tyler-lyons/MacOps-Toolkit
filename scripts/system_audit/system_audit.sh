#!/bin/bash

# ============================================================
# MacOps Toolkit - macOS System Audit
# Collects basic macOS hardware, operating system, storage,
# network, and system-status information.
# ============================================================

echo "=================================================="
echo "MACOPS TOOLKIT - SYSTEM AUDIT"
echo "=================================================="
echo

echo "REPORT INFORMATION"
echo "--------------------------------------------------"
echo "Generated: $(date)"
echo

echo "SYSTEM INFORMATION"
echo "--------------------------------------------------"
echo "Computer Name: $(scutil --get ComputerName 2>/dev/null)"
echo "Hostname: $(hostname)"
echo "Operating System: macOS"
echo "OS Version: $(sw_vers -productVersion)"
echo "OS Build: $(sw_vers -buildVersion)"
echo "Architecture: $(uname -m)"
echo

echo "HARDWARE INFORMATION"
echo "--------------------------------------------------"
echo "Processor: $(sysctl -n machdep.cpu.brand_string 2>/dev/null)"
echo "Physical CPU Cores: $(sysctl -n hw.physicalcpu)"
echo "Logical CPU Cores: $(sysctl -n hw.logicalcpu)"

memory_bytes=$(sysctl -n hw.memsize)
memory_gb=$((memory_bytes / 1024 / 1024 / 1024))

echo "Installed Memory: ${memory_gb} GB"
echo

echo "USER INFORMATION"
echo "--------------------------------------------------"
echo "Current User: $(whoami)"
echo "Home Directory: $HOME"
echo "Shell: $SHELL"
echo

echo "SYSTEM STATUS"
echo "--------------------------------------------------"
echo "Uptime: $(uptime)"
echo

echo "STORAGE"
echo "--------------------------------------------------"
df -h /
echo

echo "NETWORK INFORMATION"
echo "--------------------------------------------------"

active_interface=$(route get default 2>/dev/null | awk '/interface:/{print $2}')

if [ -n "$active_interface" ]; then
    echo "Active Interface: $active_interface"

    local_ip=$(ipconfig getifaddr "$active_interface" 2>/dev/null)

    if [ -n "$local_ip" ]; then
        echo "Local IP Address: $local_ip"
    else
        echo "Local IP Address: Not detected"
    fi
else
    echo "Active Interface: Not detected"
    echo "Local IP Address: Not detected"
fi

echo
echo "=================================================="
echo "SYSTEM AUDIT COMPLETE"
echo "=================================================="
