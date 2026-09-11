#!/bin/bash

# ============================================================
# MacOps Toolkit - Disk Health
# Reviews internal storage hardware, SMART status, filesystem
# information, and storage utilization without modifying disks.
# ============================================================

echo "=================================================="
echo "MACOPS TOOLKIT - DISK HEALTH"
echo "=================================================="
echo

echo "REPORT INFORMATION"
echo "--------------------------------------------------"
echo "Generated: $(date)"
echo

root_device=$(diskutil info / | awk -F': *' '/Device Identifier/{print $2; exit}')
physical_store=$(diskutil info / | awk -F': *' '/APFS Physical Store/{print $2; exit}')

if [ -n "$physical_store" ]; then
    physical_disk=$(diskutil info "$physical_store" | awk -F': *' '/Part of Whole/{print $2; exit}')
else
    physical_disk=""
fi

echo "PHYSICAL DISK"
echo "--------------------------------------------------"

if [ -n "$physical_disk" ]; then
    disk_info=$(diskutil info "$physical_disk")

    media_name=$(echo "$disk_info" | awk -F': *' '/Device \/ Media Name/{print $2; exit}')
    disk_size=$(echo "$disk_info" | awk -F': *' '/Disk Size/{print $2; exit}')
    protocol=$(echo "$disk_info" | awk -F': *' '/Protocol/{print $2; exit}')
    solid_state=$(echo "$disk_info" | awk -F': *' '/Solid State/{print $2; exit}')
    device_location=$(echo "$disk_info" | awk -F': *' '/Device Location/{print $2; exit}')
    smart_status=$(echo "$disk_info" | awk -F': *' '/SMART Status/{print $2; exit}')

    echo "Physical Disk: $physical_disk"
    echo "Model: $media_name"
    echo "Capacity: $disk_size"
    echo "Protocol: $protocol"
    echo "Solid State: $solid_state"
    echo "Location: $device_location"
else
    echo "[INFO] Physical disk could not be determined"
fi

echo

echo "SMART HEALTH"
echo "--------------------------------------------------"

if [ "$smart_status" = "Verified" ]; then
    echo "[PASS] SMART Status: Verified"
elif [ -n "$smart_status" ]; then
    echo "[WARN] SMART Status: $smart_status"
else
    echo "[INFO] SMART status not available"
fi

echo

echo "FILESYSTEM USAGE"
echo "--------------------------------------------------"

df -H /

usage_percent=$(df -H / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo

if [ "$usage_percent" -ge 90 ]; then
    echo "[WARN] Root filesystem usage is ${usage_percent}%"
elif [ "$usage_percent" -ge 80 ]; then
    echo "[INFO] Root filesystem usage is ${usage_percent}%"
else
    echo "[PASS] Root filesystem usage is ${usage_percent}%"
fi

echo

echo "APFS STORAGE"
echo "--------------------------------------------------"

container_total=$(diskutil info / | awk -F': *' '/Container Total Space/{print $2; exit}')
container_free=$(diskutil info / | awk -F': *' '/Container Free Space/{print $2; exit}')

echo "Root Device: $root_device"
echo "APFS Physical Store: $physical_store"
echo "Container Total Space: $container_total"
echo "Container Free Space: $container_free"
echo

echo "DISK HEALTH SUMMARY"
echo "--------------------------------------------------"

if [ "$smart_status" = "Verified" ]; then
    echo "[PASS] Physical disk health check"
else
    echo "[INFO] Review physical disk health information"
fi

if [ "$usage_percent" -lt 90 ]; then
    echo "[PASS] Storage capacity within configured threshold"
else
    echo "[WARN] Storage capacity requires attention"
fi

echo
echo "=================================================="
echo "DISK HEALTH CHECK COMPLETE"
echo "=================================================="
