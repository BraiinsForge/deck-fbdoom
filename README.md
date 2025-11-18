DOOM for Braiins Forge DECK based on awesome https://github.com/maximevince/fbDOOM project!

# How do I run it? Easy way!
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
./fbdoom -iwad DOOM.WAD`
```


