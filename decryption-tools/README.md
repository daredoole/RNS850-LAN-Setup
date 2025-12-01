# DrGER copie_scr.sh Decryption Tools

This directory contains tools and documentation for decrypting/encrypting DrGER's copie_scr.sh files used in Audi/VW MMI systems.

## Files

- **`copie_scr_decoder.exe`** - Official compiled decoder (Windows)
- **`copie_scr_decoder.c`** - C source code for the decoder
- **`decoder.ps1`** - PowerShell implementation of the decoder
- **`final_decoder.ps1`** - Complete PowerShell decoder with hex output

## Usage

### Using the Official Decoder (Recommended)

**Compile on Unix/Linux:**
```bash
gcc -o copiescrio copie_scr_decoder.c
```

**Decrypt an encoded file:**
```bash
# Unix/Linux
copiescrio < copie_scr.sh > copie_scr_decoded.txt

# Windows (PowerShell)
cmd /c "copie_scr_decoder.exe < copie_scr.sh > copie_scr_decoded.txt"
```

**Encrypt a plain text file:**
```bash
# Unix/Linux  
copiescrio < copie_scr_plain.txt > copie_scr.sh

# Windows (PowerShell)
cmd /c "copie_scr_decoder.exe < copie_scr_plain.txt > copie_scr.sh"
```

### Using PowerShell Decoder

```powershell
# Decrypt using our PowerShell implementation
.\decoder.ps1
```

## Algorithm Details

The copie_scr.sh files use a custom PRNG-based XOR cipher:

- **Initial seed:** `0x001be3ac`
- **Method:** Each byte is XORed with output from a custom PRNG
- **PRNG:** Custom algorithm that manipulates the seed using bit shifts and arithmetic

## Credits

- **DrGER** - Original encoding algorithm and forum documentation
- **megusta1337** - C source code implementation on GitHub
- **Audizine Forum** - Community documentation and sharing

## References

- [DrGER's Forum Post](https://www.audizine.com/forum/showthread.php/946917-New-and-Improved-Encoded-copie_scr-sh-Script)
- [GitHub Repository](https://github.com/megusta1337/Copie_scr_Decoder)
