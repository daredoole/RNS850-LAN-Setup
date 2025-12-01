#!/bin/ksh

# 20221212 drger: Update NWS configuration
# 20220320 drger; DLink USB Ethernet adapter settings

# Script startup env from copie_scr.sh

# Emergency logging BEFORE showScreen
echo "EMERGENCY LOG START: $(date)" > ${SDPATH}/emergency.log 2>&1
echo "SDPATH=${SDPATH}" >> ${SDPATH}/emergency.log 2>&1
echo "SDLIB=${SDLIB}" >> ${SDPATH}/emergency.log 2>&1
echo "SDVAR=${SDVAR}" >> ${SDPATH}/emergency.log 2>&1

showScreen ${SDLIB}/lansetup-0.png
sleep 2
touch ${SDPATH}/.started
xlogfile=${SDPATH}/run-$(getTime).log
exec > ${xlogfile} 2>&1
echo "[INFO] ========================================"
echo "[INFO] RNS-850 LAN Setup Script Started"
echo "[INFO] ========================================"
echo "[INFO] Start: $(date); Timestamp: $(getTime); MU version: $MUVER"
echo "[INFO] Log file: ${xlogfile}"
echo "[INFO] Installing fair-mode on $SWTRAIN ..."
echo ""

# Function to log errors and continue
log_error() {
    echo "[ERROR] $1"
}

# Function to log warnings
log_warn() {
    echo "[WARN] $1"
}

# Verify critical paths exist
echo "[INFO] Verifying environment..."
if [ ! -d "${SDVAR}" ]; then
    log_error "SDVAR directory not found: ${SDVAR}"
    exit 1
fi
echo "[INFO] SDVAR: ${SDVAR}"
echo "[INFO] SDLIB: ${SDLIB}"
echo "[INFO] SDPATH: ${SDPATH}"
echo ""

SOURCE=/mnt/efs-system/scripts/Connectivity

echo; echo "[ACTI] Copying data for LAN."
mes=/mnt/efs-system

# Verify critical directories exist
if [ ! -d "$mes" ]; then
    log_error "EFS system mount point not found: $mes"
    exit 1
fi

# Remount efs-system as read-write
echo "[INFO] Remounting $mes as read-write..."
mount -uw $mes
if [ $? -ne 0 ]; then
    log_error "Failed to remount $mes as read-write"
    exit 1
fi
echo "[INFO] Successfully remounted $mes"

# Backup GSM related files:
if [ -f /etc/browser/common.cfg ]
then
  echo; echo "[ACTI] Saving /etc/browser/common.cfg"
  cp -v /etc/browser/common.cfg ${SDVAR}/etc-browser-common.cfg-GSM
  mv -v /etc/browser/common.cfg /etc/browser/common.cfg-GSM
fi

if [ -f /lsd/poiproducer.properties ]
then
  echo; echo "[ACTI] Saving /lsd/poiproducer.properties"
  cp -v /lsd/poiproducer.properties ${SDVAR}/lsd-poiproducer.properties-GSM
  mv -v /lsd/poiproducer.properties /lsd/poiproducer.properties-GSM
fi

if [ -f /etc/ppp/pf.conf ]
then
  echo; echo "[ACTI] Saving /etc/ppp/pf.conf"
  cp -v /etc/ppp/pf.conf ${SDVAR}/etc-ppp-pf.conf-GSM
  mv -v /etc/ppp/pf.conf /etc/ppp/pf.conf-GSM
fi

# Backup network configuration
nwsbin=/mnt/efs-system/pss/nws/usr/bin
if [ -f ${nwsbin}/dhcp-down ]
then
  echo; echo "[ACTI] Saving dhcp-down"
  mv -v ${nwsbin}/dhcp-down ${nwsbin}/dhcp-down-GSM
fi

if [ -f ${nwsbin}/dhcp-up ]
then
  echo; echo "[ACTI] Saving dhcp-up"
  mv -v ${nwsbin}/dhcp-up ${nwsbin}/dhcp-up-GSM
fi

if [ -f ${nwsbin}/dnsrdr1.conf ]
then
  echo; echo "[ACTI] Saving dnsrdr1.conf"
  mv -v ${nwsbin}/dndrdr1.conf ${nwsbin}/dndrdr1.conf-GSM
fi

if [ -f ${nwsbin}/dnsrdr2.conf ]
then
  echo; echo "[ACTI] Saving dnsrdr2.conf"
  mv -v ${nwsbin}/dndrdr2.conf ${nwsbin}/dndrdr2.conf-GSM
fi

if [ -f ${nwsbin}/nws.cfg ]
then
  echo; echo "[ACTI] Saving nws.cfg"
  mv -v ${nwsbin}/nws.cfg ${nwsbin}/nws.cfg-GSM
fi

echo; echo "[INFO] RNS-850 LAN setup..."
echo "[ACTI] Install resolv.conf-FIXEDIP"

# Verify source file exists
if [ ! -f ${SDVAR}/resolv.conf-FIXEDIP ]; then
    log_error "Source file not found: ${SDVAR}/resolv.conf-FIXEDIP"
    exit 1
fi

# Verify destination directories exist
if [ ! -d ${mes}/scripts/Connectivity ]; then
    log_warn "Connectivity directory does not exist: ${mes}/scripts/Connectivity"
fi

cp -v ${SDVAR}/resolv.conf-FIXEDIP ${mes}/scripts/Connectivity/
if [ $? -ne 0 ]; then
    log_error "Failed to copy resolv.conf-FIXEDIP to Connectivity directory"
fi

cp -v ${SDVAR}/resolv.conf-FIXEDIP ${mes}/etc/resolv.conf
if [ $? -ne 0 ]; then
    log_error "Failed to copy resolv.conf-FIXEDIP to /etc/resolv.conf"
    exit 1
fi
echo "[INFO] resolv.conf-FIXEDIP installed successfully"

echo; echo "[ACTI] Create usedhcp flag."
touch /HBpersistence/usedhcp
if [ $? -ne 0 ]; then
    log_error "Failed to create usedhcp flag"
fi

echo; echo "[ACTI] Create DLinkReplacesPPP flag."
touch /HBpersistence/DLinkReplacesPPP
if [ $? -ne 0 ]; then
    log_error "Failed to create DLinkReplacesPPP flag"
fi

echo; echo "[ACTI] Copy common.cfg."
if [ -f ${SOURCE}/common.cfg ]; then
    cp -v ${SOURCE}/common.cfg /etc/browser/common.cfg
    if [ $? -ne 0 ]; then
        log_error "Failed to copy common.cfg"
    fi
else
    log_warn "Source file not found: ${SOURCE}/common.cfg"
fi

echo; echo "[ACTI] Copy poiproducer.properties"
if [ -f ${SOURCE}/poiproducer.properties ]; then
    cp -v ${SOURCE}/poiproducer.properties /lsd/poiproducer.properties
    if [ $? -ne 0 ]; then
        log_error "Failed to copy poiproducer.properties"
    fi
else
    log_warn "Source file not found: ${SOURCE}/poiproducer.properties"
fi

echo; echo "[ACTI] Copy pf.conf"
if [ -f ${SOURCE}/pf.conf ]; then
    cp -v ${SOURCE}/pf.conf /etc/ppp/pf.conf
    if [ $? -ne 0 ]; then
        log_error "Failed to copy pf.conf"
    fi
else
    log_warn "Source file not found: ${SOURCE}/pf.conf"
fi

# Verify nwsbin directory exists
echo; echo "[INFO] Verifying network service binary directory..."
if [ ! -d "${nwsbin}" ]; then
    log_error "NWS binary directory not found: ${nwsbin}"
    exit 1
fi
echo "[INFO] NWS binary directory verified: ${nwsbin}"

echo; echo "[ACTI] Copy dhcp-down"
if [ -f ${SDVAR}/dhcp-down-LAN ]; then
    cp -v ${SDVAR}/dhcp-down-LAN ${nwsbin}/dhcp-down-LAN
    cp -v ${SDVAR}/dhcp-down-LAN ${nwsbin}/dhcp-down
    if [ $? -ne 0 ]; then
        log_error "Failed to copy dhcp-down"
    fi
else
    log_error "Source file not found: ${SDVAR}/dhcp-down-LAN"
fi

echo; echo "[ACTI] Copy dhcp-up"
if [ -f ${SDVAR}/dhcp-up-LAN ]; then
    cp -v ${SDVAR}/dhcp-up-LAN ${nwsbin}/dhcp-up-LAN
    cp -v ${SDVAR}/dhcp-up-LAN ${nwsbin}/dhcp-up
    if [ $? -ne 0 ]; then
        log_error "Failed to copy dhcp-up"
    fi
else
    log_error "Source file not found: ${SDVAR}/dhcp-up-LAN"
fi

echo; echo "[ACTI] Copy dnsrdr1.conf"
if [ -f ${SDVAR}/dnsrdr1.conf-LAN ]; then
    cp -v ${SDVAR}/dnsrdr1.conf-LAN ${nwsbin}/dnsrdr1.conf-LAN
    cp -v ${SDVAR}/dnsrdr1.conf-LAN ${nwsbin}/dnsrdr1.conf
    if [ $? -ne 0 ]; then
        log_error "Failed to copy dnsrdr1.conf"
    fi
else
    log_error "Source file not found: ${SDVAR}/dnsrdr1.conf-LAN"
fi

echo; echo "[ACTI] Copy dnsrdr2.conf"
if [ -f ${SDVAR}/dnsrdr2.conf-LAN ]; then
    cp -v ${SDVAR}/dnsrdr2.conf-LAN ${nwsbin}/dnsrdr2.conf-LAN
    cp -v ${SDVAR}/dnsrdr2.conf-LAN ${nwsbin}/dnsrdr2.conf
    if [ $? -ne 0 ]; then
        log_error "Failed to copy dnsrdr2.conf"
    fi
else
    log_error "Source file not found: ${SDVAR}/dnsrdr2.conf-LAN"
fi

echo; echo "[ACTI] Copy nws.cfg"
if [ -f ${SDVAR}/nws.cfg-LAN ]; then
    cp -v ${SDVAR}/nws.cfg-LAN ${nwsbin}/nws.cfg-LAN
    cp -v ${SDVAR}/nws.cfg-LAN ${nwsbin}/nws.cfg
    if [ $? -ne 0 ]; then
        log_error "Failed to copy nws.cfg"
        exit 1
    fi
    echo "[INFO] nws.cfg copied successfully"
else
    log_error "Source file not found: ${SDVAR}/nws.cfg-LAN"
    exit 1
fi

# Script cleanup:
echo ""
echo "[INFO] ========================================"
echo "[INFO] RNS-850 LAN Setup Completed Successfully"
echo "[INFO] ========================================"
echo "[INFO] End: $(date); Timestamp: $(getTime)"
echo "[INFO] Log saved to: ${xlogfile}"
echo ""
echo "[INFO] Configuration Summary:"
echo "[INFO]   - Router IP: 192.168.2.1"
echo "[INFO]   - RNS-850 IP: 192.168.2.2 (static)"
echo "[INFO]   - WiFi Hotspot IP: 192.168.1.1"
echo "[INFO]   - DNS: 192.168.2.1, 8.8.8.8"
echo ""
showScreen ${SDLIB}/lansetup-1.png
sleep 3
rm -f ${SDPATH}/.started
exit 0
