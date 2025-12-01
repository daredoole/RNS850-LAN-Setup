# RNS-850 Telnet Console Access NOT CONFIRMED YET

## Method 1: Via Ethernet (DLink Adapter)
1. Connect DLink USB Ethernet adapter to RNS-850
2. Connect Ethernet cable from DLink to your router
3. Router should assign IP (likely 192.168.2.x based on DHCP)
4. From your PC: `telnet <RNS-850-IP>`
5. Default user might be root (no password) or check documentation

## Method 2: Via WiFi Hotspot
1. Access Green Menu (SETUP + CAR buttons)
2. Enable WiFi Access Point
3. Connect your laptop to the RNS-850 WiFi
4. Find RNS IP: `arp -a` or try 192.168.1.1
5. Telnet to that IP

## Once Connected:
```bash
# Check if script is running
ps | grep copie_scr
ps | grep run.sh

# Check SD card mount
ls /mnt
mount | grep sdcard

# Check logs
ls -la /tmp/*.log
tail -f /tmp/run*.log

# Manually run your script
cd /mnt/sdcard*  # find the correct SD mount
./copie_scr.sh
```
