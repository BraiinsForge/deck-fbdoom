DOOM for Braiins Forge DECK based on awesome https://github.com/maximevince/fbDOOM project!


# What do I need?
- Braiins Forge DECK
- USB-C PD Power Adapter
- USB-C HUB with PD Support
- USB keyboard

# How do I run it? Easy!
### Access the DECK using SSH:

```
ssh root@<miner-ip>  # password = UI admin password you set during setup
```

### Stop the main DECK application:

```
service bmc stop # for temporary stop, after the restart the application will be started again
```
or
```
service bmc disable # for permament stop, after the restart the DECK application won't start again
```

### Copy DOOM files:
- in case you want to use precompiled sources go to the folder game_files and copy fbdoom and DOOM.WAD files to the DECK
```
scp fbdoom doom.wad root@<miner-ip>:/root/
```

- in case you want co compile it from source, continue reading
### Run the game!
```
./fbdoom -iwad DOOM.WAD
```


# Can I compile it on my own?
Yes of course! No need to trust strangers, just clone our repository.
```
git clone github.com/BraiinsForge/deck-fbdoom.git
cd fbdoom
```

### Manual toolchain setup and build
##### Debian/Ubuntu
```
sudo apt install gcc-arm-linux-gnueabihf
```

Build with:
```
export NOSDL=1
make CROSS_COMPILE=arm-linux-gnueabihf- CFLAGS="-static -std=gnu99" LDFLAGS="-static"
```
Note that we need to compile with -std=gnu99 because newer GCCs default to gnu23 based on C23, in which several DOOM source files have compilation errors.
