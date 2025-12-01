# RNS-850 Telnet Console Access

⚠️ **Status: NOT YET CONFIRMED ON RNS-850 HARDWARE**

These are theoretical methods based on MMI3G documentation. Actual RNS-850 behavior may differ.

## Method 1: Via Ethernet (DLink Adapter)

1. **Connect DLink USB Ethernet adapter** to RNS-850
2. **Connect Ethernet cable** from DLink to your router/switch
3. **Router assigns IP** (should be 192.168.2.x based on our DHCP config)
4. **From your PC:** `telnet <RNS-850-IP>` 
5. **Default credentials:** Usually `root` (no password) - check MMI documentation

### Find RNS-850 IP:
```bash
# Scan for devices on your network
nmap -sn 192.168.2.0/24

# Check ARP table
arp -a | grep 192.168.2
```

## Method 2: Via WiFi Hotspot

1. **Access Green Menu** (SETUP + CAR buttons simultaneously)
2. **Enable WiFi Access Point** in network settings
3. **Connect laptop** to the RNS-850 WiFi network
4. **Find RNS IP:** `arp -a` or try common IPs:
   - `192.168.1.1` (typical hotspot gateway)
   - `192.168.1.2` 
5. **Telnet:** `telnet <discovered-ip>`

## Method 3: Direct Console (If Available)

Some MMI units have hidden debug ports. Check for:
- **Mini USB ports** (may be behind panels)
- **Serial console access** via service connectors
- **Service mode activation** with specific button combinations

---

## Once Connected (If Successful):

### Basic System Check
```bash
# Check if our scripts ran
ps | grep copie_scr
ps | grep run.sh

# Check SD card mounting
ls /mnt
mount | grep sdcard

# Check our logs
ls -la /tmp/*.log
tail -f /tmp/run*.log
ls -la /tmp/emergency.log
```

### Network Diagnostics  
```bash
# Check network interfaces
ifconfig -a

# Check IP configuration
ip addr show

# Check routing
route -n

# Test connectivity
ping 8.8.8.8
ping 192.168.2.1
```

### Manual Script Execution
```bash
# Navigate to SD card mount
cd /mnt/sdcard*  # Find the correct mount point
ls -la

# Check script permissions
ls -la copie_scr.sh run.sh

# Manual execution (if auto-launch failed)
./copie_scr.sh
# OR directly:
./run.sh
```

### System Information
```bash
# Check MMI version info
cat /dev/shmem/sw_trainname.txt

# Check hardware info
cat /proc/cpuinfo
cat /proc/meminfo
lsusb
lspci

# Check running services
ps aux
netstat -tlnp
```

---

## ⚠️ Important Notes

### For RNS-850 Specifically:
- **Different QNX version** may have different network stack
- **SSH might be available** instead of or alongside telnet  
- **Different default credentials** possible
- **Port 22 (SSH)** or port 23 (telnet) - try both

### Security Considerations:
- **Change default passwords** if access is gained
- **Document access method** for future reference  
- **Be careful with system modifications** - can brick the unit
- **Backup configurations** before making changes

### Troubleshooting Access:
```bash
# Try different ports
telnet <ip> 22    # SSH
telnet <ip> 23    # Telnet
telnet <ip> 80    # HTTP (web interface?)

# Try common default credentials:
# root / (no password)
# root / root
# admin / admin  
# mmi / mmi
```

---

## 🔍 Help Wanted

**If you successfully gain telnet/SSH access to RNS-850:**

1. **Document the exact method** used
2. **Share network configuration** details
3. **Provide system information** output
4. **Test our LAN setup scripts** and report results
5. **Update this documentation** with confirmed working methods

**This will help the entire RNS-850 community!**

---

## 📚 References

- Original MMI3G telnet documentation
- DrGER's MMI development notes  
- Audizine forum discussions on MMI access
- QNX system administration guides
