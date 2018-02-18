# BlackArch Slim ISO
## A smaller ISO compared to the regular one, with selected packages.

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
READ READ READ!

## Screenshots

![empty](docs/empty.png)
![fakebusy](docs/fakebusy.png)
![another fakebusy](docs/fakebusy1.png)

## Suggestions

- If you have any ideas, please consider opening an issue.
  Make sure to use the description box and write a useful and informative issue.

- If you would like to see an application installed by default in the ISO make
  sure to create an issue or pull request describing why it would be a good idea
  to have that specific tool installed.

