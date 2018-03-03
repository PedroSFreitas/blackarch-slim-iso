# BlackArch Slim ISO
## A smaller ISO compared to the regular one, with selected packages.

## Image

For testing:
https://mega.nz/#!rkZXXDRQ!JTWbGOzosplJ1rwDgZsVZBxjNKRNqm2z6WoFdlm1L_s


sha1sum: 3f42da494109d6c20167e24a4a6e5683495412a9 


ref. to commit: 376e63873565a995eb879605bcb829bf38f29fd1


important: this Live ISO could be out of date, not reflecting the actual state
of the repository.


## Map

- build.sh: Script to create the image.

- packages.x86_64: Default packages to be installed on the Live ISO.

- airootfs/root/customize_airootfs.sh: Script that runs commands on the Live ISO
  during the building process. You can modify this file to run any
  administration command or to modify any configuration file.

## Building the Image

Building the image is only possible on an Arch Linux installation.
Clone the repo and run the following **as root**:

```
# cd blackarch-slim-iso
# rm -rfv out work
# mkdir out work
# ./build.sh -v
```

The finished ISO will be located in the `out` folder.

login:
- root:blackarch

Note: make sure to check the README inside Desktop.

## Installation

- The Arch way. Read: https://wiki.archlinux.org/index.php/archiso#Installation_without_Internet_access

Note: following the offline installation guide, you'll have to change this command:

`cp -vaT /run/archiso/bootmnt/arch/boot/$(uname -m)/vmlinuz /mnt/boot/vmlinuz-linux`

to

`cp -vaT /run/archiso/bootmnt/blackarch/boot/$(uname -m)/vmlinuz /mnt/boot/vmlinuz-linux`


- It's also important to mention that offline installation will install 
everything that the Live ISO has. It means you'll have applications that you
don't necessarily need, i.e.: gpu drivers, etc. Make sure to do a clean up
after.


- And YES you can use this same ISO to install Vanilla Arch Linux! Yep!
Just follow the https://wiki.archlinux.org/index.php/installation_guide and you
should be good.

## Screenshots

![login](docs/login.png)
![empty](docs/empty.png)
![fakebusy](docs/fakebusy.png)
![another fakebusy](docs/fakebusy1.png)

## Suggestions

- If you have any ideas, please consider opening an issue.
  Make sure to use the description box and write a useful and informative issue.

- If you would like to see an application installed by default in the ISO make
  sure to create an issue or pull request describing why it would be a good idea
  to have that specific tool installed.

