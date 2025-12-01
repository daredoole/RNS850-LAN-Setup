# Examples Directory

⚠️ **Note: This directory currently contains broken/incomplete files and is not recommended for use.**

## Current Status

The example files in this repository appear to be corrupted or incomplete. The decoded scripts end abruptly with incomplete shell syntax:

```bash
if [ -e /etc/pci-3g_9304.cfg
```

This line is missing:
- Closing bracket `]`  
- `then` keyword
- Actual conditional logic
- Closing `fi` statement

## Recommendation

**For RNS-850 use, always use the files in the `script/` directory**, which contain:
- ✅ Complete, working shell scripts
- ✅ Properly tested for RNS-850 platform
- ✅ Valid syntax that will execute without errors

## Purpose of This Directory

This directory is kept for historical reference and reverse engineering documentation, but should not be used for actual deployment.

## Working Files Location

All working, tested files are located in:
- **`../script/`** - Complete RNS-850 setup scripts (ready to copy to SD card)
