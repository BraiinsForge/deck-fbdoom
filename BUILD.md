# Building DOOM for Braiins Forge Deck

This guide explains how to build fbDOOM from source for the Braiins Forge Deck.

## Prerequisites

The Deck uses an ARM-based processor (armv7), so you'll need a cross-compilation toolchain if you're building from a non-ARM system.

## Option 1: Using Nix (Recommended)

The easiest way to build fbDOOM is using the provided Nix flake, which sets up the complete cross-compilation environment automatically.

You can build directly without cloning:
```bash
nix build github:BraiinsForge/deck-fbdoom#doom-deck
```

The binary will be at `./result/bin/fbdoom`.

**Note:** To build for Braiins MiniMiner instead (with only the BGR color fix), use `#doom-bmm` instead of `#doom-deck`.

### Setup

1. Install Nix with flakes support (if not already installed):
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. Clone this repository with submodules:
   ```bash
   git clone --recursive git@github.com:BraiinsForge/deck-fbdoom.git
   cd deck-fbdoom
   ```

3. Enter the Nix development environment:
   ```bash
   nix develop
   ```

   **Note:** The first run downloads the ARM toolchain and builds dependencies, which can take several minutes.

### Building

Once inside the Nix environment:

```bash
cd fbdoom
make
```

The compiled binary will be at `./fbdoom/fbdoom`.

## Option 2: Manual Toolchain Setup

If you prefer not to use Nix, you can manually install an ARM cross-compiler.

### Install ARM Toolchain

**Debian/Ubuntu:**
```bash
sudo apt install gcc-arm-linux-gnueabihf
```

**Arch Linux:**
```bash
yay -S arm-linux-gnueabihf-gcc
```

### Clone Repository

```bash
git clone --recursive git@github.com:BraiinsForge/deck-fbdoom.git
cd deck-fbdoom
```

### Build

```bash
cd fbdoom
export NOSDL=1
make CROSS_COMPILE=arm-linux-gnueabihf- CFLAGS="-static -std=gnu99" LDFLAGS="-static"
```

**Important:** We compile with `-std=gnu99` because newer GCC versions default to gnu23 (based on C23), which causes compilation errors in some DOOM source files.

The compiled binary will be at `./fbdoom/fbdoom`.

## Option 3: Native Compilation on Deck

You can compile directly on the Deck, but this requires significant storage space for the toolchain. It's recommended to use an SD card with a chroot environment.

## Getting DOOM WAD Files

The game requires a DOOM IWAD file (game data). You can:

1. Download shareware DOOM from [Archive.org](https://archive.org/details/theultimatedoom_doom2_doom.wad)
2. Use your legally purchased DOOM game files

## Display Configuration

The Braiins Forge Deck uses a portrait LCD in landscape mode with specific framebuffer requirements. Our fork includes these patches:

- 90-degree rotation support
- BGR565 framebuffer format
- Display offset configuration for proper centering

These modifications are in `fbdoom/i_video_fbdev.c` and are automatically included when building from our fork.
