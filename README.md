# BlackArch Slim ISO
## A smaller ISO compared to the regular one, with selected packages.

## Map

- build.sh: script to create the image.

- packages.x86_64: default packages to be installed on the Live ISO.

- airootfs/root/customize_airootfs.sh: script that runs commands on the Live ISO
  during the building process. You can modify this file to run any
  administration command or to modify any configuration file.

## To build the image

- run (considering you have already git clone'd the repository and cd'd to it):
```
rm -rfv out work
mkdir out work
./build.sh -v
```

- the iso will be outputed to the `out/` folder.

## Sreenshots

![empty](docs/empty.png)
![fakebusy](docs/fakebusy.png)
![another fakebusy](docs/fakebusy1.png)

## Suggestion, ideas?

- if you have any ideas, consider open an Issue.
  Please, make use of the description box and right an useful issue.

- if you would like to see an application to be installed by default in the ISO
  make sure to create an Issue or PR describing why it would be a good idea to
  have that specific tool installed.

