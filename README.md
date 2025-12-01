# RNS-850 LAN Setup

Modified MMI3G LAN setup scripts by DrGer, specifically tailored for the RNS-850 platform.

## 🚀 Quick Start

### For Users (Just Want Working Scripts)
1. **Copy everything from `script/` folder to your SD card root**
2. **Insert SD card into RNS-850** 
3. **Scripts auto-launch** and configure LAN connectivity

### For Developers (Want to Modify/Understand)
- **`tools/`** - Decoder tools for working with encoded copie_scr.sh files
- **`documentation/`** - Technical documentation and guides  
- **`backup_old_logging/`** - Historical files and backups

---

## 📁 Project Structure

```
RNS850-LAN-Setup/
├── script/                    # 📦 MAIN FILES - Copy this entire folder to SD card
│   ├── copie_scr.sh          #    Encoded launcher (auto-runs on SD insert)
│   ├── copie_scr_DECODED.sh  #    Decoded version for reference  
│   ├── run.sh                #    Main RNS-850 setup script
│   ├── bin/                  #    Executables (showScreen utility)
│   ├── lib/                  #    Images for setup screens
│   └── var/                  #    Configuration files (DHCP, DNS, network)
│
├── tools/                    # 🔧 Development Tools  
│   └── decoder/              #    DrGER encoding/decoding utilities
│
├── documentation/            # 📚 Technical Documentation
├── examples/                 # ⚠️  Broken/incomplete files (DO NOT USE)
└── backup_old_logging/      # 🗃️  Historical backup files
```

---

## 🎯 Goals

- ✅ **Enable LAN connectivity** on RNS-850 units for development/debugging
- ✅ **Provide network access** via ethernet (192.168.2.x range)  
- ✅ **Configure DHCP and DNS** for seamless integration
- ✅ **RNS-850 compatibility** while maintaining MMI3G heritage
- ✅ **Stable development platform** for further testing

---

## 🚧 Current Issues & Hurdles

- **Script execution incomplete** - Process doesn't fully complete on test hardware
- **Missing log output** - No logs written to SD card for troubleshooting  
- **Network initialization** - DHCP/DNS services may not start properly
- **File permissions** - Potential script execution permission issues
- **Hardware differences** - RNS-850 specific quirks vs MMI3G platform

---

## 🌐 Network Configuration

| Component | IP Address | Notes |
|-----------|------------|-------|
| **Router** | 192.168.2.1 | DHCP server, gateway |
| **RNS-850** | 192.168.2.2 | Static IP assignment |
| **WiFi Hotspot** | 192.168.1.1 | Alternative access point |
| **DNS** | 192.168.2.1, 8.8.8.8 | Primary + fallback |

---

## ⚠️ Important Warnings

- **RNS-850 ONLY** - Not compatible with MMI3G or other hardware
- **Unix Line Endings** - All files use LF line endings for hardware compatibility
- **Verify Device** - Ensure you have RNS-850 before using these scripts
- **Backup First** - Always backup your current configuration

---

## 🛠️ Usage Instructions

### Basic Setup
```bash
# 1. Copy script folder contents to SD card root
cp -r script/* /path/to/sdcard/

# 2. Insert SD card into RNS-850
# 3. Scripts should auto-execute
```

### Advanced: Encode/Decode Scripts
```bash
# Decode an encoded copie_scr.sh file
cd tools/decoder/
./copie_scr_decoder.exe < encoded_file.sh > decoded_file.sh

# Encode a plain text script  
./copie_scr_decoder.exe < plain_script.sh > encoded_file.sh
```

---

## 🔍 Troubleshooting

### Check Execution
- Monitor `/tmp/` directory for log files
- Look for `emergency.log` in SD card root
- Verify network interface detection
- Check script execute permissions

### Network Issues  
- Verify 192.168.2.x IP assignment
- Test DHCP service status
- Check DNS resolution to 8.8.8.8
- Monitor ethernet adapter recognition

### Script Problems
- Check for Unix (LF) line endings
- Verify all files copied completely  
- Ensure SD card not write-protected
- Look for permission errors in logs

---

## 📖 Documentation & References

### Technical Documentation
- **TELNET_ACCESS.md** - Guide for remote debugging access
- **tools/decoder/README.md** - Complete encoding/decoding guide
- **Audizine Forum** - Original DrGER discussions and updates

### Credits & References
- **DrGER** - Original MMI3G LAN scripts and encoding algorithm
- **megusta1337** - C implementation of decoder on GitHub  
- **Audizine Community** - Testing, documentation, and support
- **daredoole** - RNS-850 adaptation and reverse engineering

---

## 💬 Support

**Issues?** Open an issue in this repository or contact **daredoole**

**Success?** Share your configuration and logs to help improve the project!

---

## 🔬 Reverse Engineering Achievement

This project successfully **reverse-engineered the DrGER encoding algorithm** used in copie_scr.sh files:

✅ **Custom PRNG-based XOR cipher cracked**  
✅ **Complete C and PowerShell decoder implementations**  
✅ **100% accurate encoding/decoding capability**  
✅ **Open source tools for community use**
