# RNS-850 LAN Setup
This repository contains a modified version of the MMI3G LAN setup scripts by DrGer, specifically tailored for the RNS-850 platform.

## Quick Start for RNS-850

1. **Copy the main folders to your SD card:**
   - Copy `bin/`, `lib/`, and `var/` folders to your SD card root
   - Copy `copie_scr.sh` (encoded) to SD card root  
   - Copy `run.sh` to SD card root

2. **Insert SD card into RNS-850** and the script should auto-execute

## Goals
- **Enable LAN connectivity** on RNS-850 units for development and debugging
- **Provide network access** through ethernet connection (192.168.2.x range)
- **Configure DHCP and DNS** services for seamless network integration
- **Maintain compatibility** with RNS-850 hardware limitations and requirements
- **Create stable platform** for further development and testing

## Current Hurdles
- **Script execution incomplete**: Process doesn't fully complete on test hardware
- **Missing log output**: No logs are written to SD card for troubleshooting
- **Network initialization**: DHCP and DNS services may not start properly
- **File permissions**: Potential issues with script execution permissions
- **Hardware differences**: RNS-850 specific quirks compared to MMI3G platform

## Directory Structure

### Main Script Files (Copy these to SD card)
- **`copie_scr.sh`** - Encoded script launcher (auto-executes on SD insert)
- **`copie_scr_DECODED.sh`** - Decoded version for reference
- **`run.sh`** - Main LAN setup script for RNS-850
- **`bin/`** - Binary files and utilities
- **`lib/`** - Screen images for setup process
- **`var/`** - Configuration files for RNS-850

### Documentation & Tools
- **`decryption-tools/`** - Tools for encoding/decoding copie_scr.sh files
- **`examples/`** - Example decoded files and documentation
- **`backup_old_logging/`** - Backup files and previous versions
- **`TELNET_ACCESS.md`** - Guide for accessing RNS-850 via telnet

## Purpose
- This version is **not compatible** with MMI3G or other hardware
- All network, DHCP, and DNS settings are adjusted for RNS-850 requirements
- Configuration uses 192.168.2.x IP range instead of standard ranges

## Usage
- Ensure your device is an RNS-850 before using these scripts
- All configuration files use Unix (LF) line endings for hardware compatibility
- Insert SD card with files copied - script should auto-run

## Troubleshooting
- Check SD card for log files in `/tmp` directory
- Verify network interface is detected properly
- Ensure scripts have execute permissions
- Monitor DHCP service status during setup
- Use telnet access for live debugging (see TELNET_ACCESS.md)

## Advanced: copie_scr.sh Encryption/Decryption

If you need to modify the copie_scr.sh launcher script, see the `decryption-tools/` directory for:
- Decoding tools and source code
- Instructions for encoding/decoding
- PowerShell and C implementations
- Reference to original DrGER algorithm

## Support
If you encounter issues, please open an issue in this repository or contact daredoole.
