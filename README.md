# DOOM on Braiins Forge Deck

Run the classic DOOM on your Braiins Forge Deck! This project is based on the excellent [fbDOOM](https://github.com/maximevince/fbDOOM) with custom patches for the Deck's STM32MP1 display hardware.

## What You Need

- **Braiins Forge Deck**
- **USB-C PD Power Adapter**
- **USB-C Hub with PD Support**
- **USB Keyboard**
- **DOOM WAD file** (game data)

## Quick Start

### 1. Download Pre-compiled Files

Download the latest `fbdoom` binary and `doom.wad` from our [releases page](https://github.com/BraiinsForge/deck-fbdoom/releases).

### 2. Access Your Deck via SSH

```bash
ssh root@<deck-ip>  # Use the admin password you set during setup
```

### 3. Stop the Deck Application

**Temporary stop** (will restart after reboot):
```bash
service bmc stop
```

**Permanent stop** (won't start after reboot):
```bash
service bmc disable
```

### 4. Copy Files to Your Deck

```bash
scp fbdoom doom.wad root@<deck-ip>:/root/
```

### 5. Run DOOM!

```bash
ssh root@<deck-ip>
chmod +x fbdoom
./fbdoom -iwad doom.wad
```

## Getting DOOM WAD Files

The game requires a DOOM IWAD file. You can:

- Download the shareware version from [Archive.org](https://archive.org/details/theultimatedoom_doom2_doom.wad)
- Use your legally purchased DOOM game files (DOOM.WAD, DOOM2.WAD, etc.)

## Building from Source

Want to compile fbDOOM yourself instead of using the pre-built binary? Check out [BUILD.md](BUILD.md) for complete instructions.

## License

DOOM source code is licensed under the GNU GPL. See the original fbDOOM repository for details.
