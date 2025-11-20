# Building DOOM for Braiins Forge Deck

This guide explains how to build fbDOOM from source for the Braiins Forge Deck.

## Prerequisites

The Deck uses an ARM-based processor (armv7), so you'll need a cross-compilation toolchain if you're building from a non-ARM system.

## Option 1: Using Nix (Recommended)

Nix is a reproducible build system and package manager that ensures consistent builds across different machines. The easiest way to build fbDOOM is using the provided Nix flake, which sets up the complete cross-compilation environment automatically.

Alternatively, you can build by hand if you procure an ARM cross-compilation toolchain.

### Installing Nix

If you don't have Nix installed, install it with flakes support:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

For more information, see the [Nix installation guide](https://nixos.org/download.html).

### Quick Build (Flake)

The fastest way to build is using the Nix flake directly, without cloning the repository:

```bash
nix build github:BraiinsForge/deck-fbdoom#doom-deck
```

The binary will be at `./result/bin/fbdoom`.

**Build Variants:**
- `#doom-deck` - Full Braiins Forge Deck build (BGR color fix + rotation + display offset)
- `#doom-bmm` - Braiins MiniMiner build (BGR color fix only)

### Advanced Development Workflow

For active development and iteration, use the Nix development environment:

1. Clone this repository with submodules:
   ```bash
   git clone --recursive git@github.com:BraiinsForge/deck-fbdoom.git
   cd deck-fbdoom
   ```

2. Enter the Nix development environment:
   ```bash
   nix develop
   ```

   **Note:** The first run downloads the ARM toolchain and builds dependencies, which can take several minutes.

3. Build using make:
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
