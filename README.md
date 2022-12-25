om-welcome
===========

This is the om-welcome - Welcome to OpenMandriva

designed to introduce new users to the OpenMandriva distro and
also integrate common tasks for post-installation distro.

requires the following dependencies:

- Qt WebEngineWidgets 5.x
- Bash

##### Installing Dependencies
Dependencies for running om-welcome should already be installed.
For building, use
```sh
urpmi 'cmake(Qt5WebEngineWidgets)'
```

##### Directory Structures
your files are:
```
launcher/
```
contains the launcher that takes care of running the bits in
```
usr/share/oma-welcome/
```

if you package it separately om-welcome requires changes to the running script.

##### Running OM-Welcome
you can run the om-welcome for debugging, with following command:
```sh
om-welcome -s 870x520 index.sh.htm
```
where "-s 870x520" indicates the default window size in pixels (Width x Height).
You can also use "-i /usr/share/icons/openmandriva.svg" to set the
application window's icon.

##### Translations
* inside the folder ```usr/share/om-welcome/ ```
* there is a file called translation, all texts om-welcome are it is from it that will 
* generate the translation files
* format it is as follows
```variavel=$"text that will be shown in the om-welcome"```

with the command
```sh
bash --dump-po-strings translation > om-welcome.pot
```

om-welcome.pot is the translation file.

htmlscript uses html, css and js to create the layout, if you want to make any changes or improvements,
just edit the files with the format. sh.htm, and style.css that is inside the css folder.
files with the. scripts are run that will be read as if they were running through the terminal.

to execute a command within the html files (sh.htm) using the following command:
```sh
$(command to be executed)
```

example: 
```
     $(cat /etc/os-release | cut -d"=" -f2) #shows the name of the Linux distribution
```      
