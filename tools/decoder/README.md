# DrGER copie_scr.sh Decoder Tools

Tools and documentation for decrypting/encrypting DrGER's copie_scr.sh files used in Audi/VW MMI systems.

## Files

- **`copie_scr_decoder.exe`** - Official compiled decoder (Windows, 125KB)
- **`copie_scr_decoder.c`** - C source code for the decoder algorithm
- **`copie_scr_DECODED_EXAMPLE.sh`** - ⚠️ Incomplete/corrupted example (DO NOT USE)

## ⚠️ Important Warning

The `copie_scr_DECODED_EXAMPLE.sh` file in this directory is **incomplete and will not work**. It ends with invalid shell syntax:
```bash
if [ -e /etc/pci-3g_9304.cfg
```

**For working scripts, always use the files in `../script/` directory.**

## Usage

### Compile on Unix/Linux:
```bash
gcc -o copie_scr_decoder copie_scr_decoder.c
```

### Decrypt an encoded file:
```bash
# Unix/Linux
./copie_scr_decoder < encoded_file.sh > decoded_file.txt

# Windows (PowerShell - in this directory)
cmd /c "copie_scr_decoder.exe < encoded_file.sh > decoded_file.txt"
```

### Encrypt a plain text file:
```bash
# Unix/Linux  
./copie_scr_decoder < plain_script.txt > encoded_file.sh

# Windows (PowerShell - in this directory)
cmd /c "copie_scr_decoder.exe < plain_script.txt > encoded_file.sh"
```

## Algorithm Details

The copie_scr.sh files use a **custom PRNG-based XOR cipher**:

- **Initial seed:** `0x001be3ac`
- **Method:** Each byte is XORed with output from a custom PRNG
- **Encryption/Decryption:** Same algorithm (XOR is reversible)

### PRNG Algorithm:
```c
unsigned int prng_rand() {
    unsigned int r1, r3, r0;
    r0 = seed;
    r1 = (seed >> 1) | (seed << 31);
    r3 = ((r1 >> 16) & 0xFF) + r1;
    r1 = ((r3 >> 8) & 0xFF) << 16;
    r3 -= r1;
    seed = r3;
    return r0;
}
```

## ✅ Successfully Reverse Engineered

This decoder was successfully reverse-engineered by analyzing:
1. DrGER's forum posts and documentation
2. The original C source code from GitHub
3. Extensive testing and validation

The algorithm works perfectly for encoding/decoding valid copie_scr.sh files.

## Credits

- **DrGER** - Original encoding algorithm and MMI development
- **megusta1337** - C source code implementation on GitHub
- **Audizine Forum Community** - Documentation and sharing
- **daredoole** - Reverse engineering and PowerShell implementation

## References

- [DrGER's Forum Post](https://www.audizine.com/forum/showthread.php/946917-New-and-Improved-Encoded-copie_scr-sh-Script)
- [GitHub Repository](https://github.com/megusta1337/Copie_scr_Decoder)
