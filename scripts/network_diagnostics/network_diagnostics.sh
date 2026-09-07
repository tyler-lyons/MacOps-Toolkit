#!/bin/bash

# ============================================================
# MacOps Toolkit - Network Diagnostics
# Checks local network configuration, gateway connectivity,
# internet connectivity, and DNS resolution.
# ============================================================

echo "=================================================="
echo "MACOPS TOOLKIT - NETWORK DIAGNOSTICS"
echo "=================================================="
echo

echo "REPORT INFORMATION"
echo "--------------------------------------------------"
echo "Generated: $(date)"
echo

echo "NETWORK CONFIGURATION"
echo "--------------------------------------------------"

active_interface=$(route get default 2>/dev/null | awk '/interface:/{print $2}')
default_gateway=$(route get default 2>/dev/null | awk '/gateway:/{print $2}')

if [ -n "$active_interface" ]; then
    echo "Active Interface: $active_interface"
else
    echo "Active Interface: Not detected"
fi

local_ip=$(ipconfig getifaddr "$active_interface" 2>/dev/null)

if [ -n "$local_ip" ]; then
    echo "Local IP Address: $local_ip"
else
    echo "Local IP Address: Not detected"
fi

if [ -n "$default_gateway" ]; then
    echo "Default Gateway: $default_gateway"
else
    echo "Default Gateway: Not detected"
fi

echo

echo "DNS CONFIGURATION"
echo "--------------------------------------------------"
dns_servers=$(scutil --dns | awk '/nameserver\[[0-9]+\]/{print $3}' | sort -u)

if [ -n "$dns_servers" ]; then
    echo "$dns_servers"
else
    echo "No DNS servers detected"
fi

echo

echo "CONNECTIVITY TESTS"
echo "--------------------------------------------------"

if [ -n "$default_gateway" ]; then
    if ping -c 2 -W 1000 "$default_gateway" >/dev/null 2>&1; then
        echo "[PASS] Default gateway reachable"
    else
        echo "[FAIL] Default gateway unreachable"
    fi
else
    echo "[FAIL] Default gateway not detected"
fi

if ping -c 2 -W 1000 1.1.1.1 >/dev/null 2>&1; then
    echo "[PASS] Internet IP connectivity"
else
    echo "[FAIL] Internet IP connectivity"
fi

if dscacheutil -q host -a name example.com | grep -q "ip_address"; then
    echo "[PASS] DNS resolution"
else
    echo "[FAIL] DNS resolution"
fi

echo

echo "NETWORK SUMMARY"
echo "--------------------------------------------------"

if [ -n "$active_interface" ] && [ -n "$local_ip" ] && [ -n "$default_gateway" ]; then
    echo "[PASS] Network configuration detected"
else
    echo "[FAIL] Network configuration incomplete"
fi

echo
echo "=================================================="
echo "NETWORK DIAGNOSTICS COMPLETE"
echo "=================================================="
