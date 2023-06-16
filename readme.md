 
# **Grub Themes: Red Dead Redemption 2**

Make your Grub look like you are inside the game.

# **Previews**
|    |    |    |
|:-------:|:-------:|:---------:|
|![abigail-roberts](preview/abigail_roberts/1920x1080.png)|![arthur-morgan](preview/arthur-morgan/1920x1080.png)|![bill-williamson](preview/bill_williamson/1920x1080.png)|
|**Abigail Roberts**|**Arthur Morgan**|**Bill Williamson**|
|![charles_smith](preview/charles_smith/1920x1080.png)|![dutch_van_der_linde](preview/dutch_van_der_linde/1920x1080.png)|![hosea_matthews](preview/hosea_matthews/1920x1080.png)|
|**Charles Smith**|**Dutch Van Der Linde**|**Hosea Matthews**|
|![john-marston](preview/john-marston/1920x1080.png)|![lenny](preview/mary_beth/1920x1080.png)|![micah-bell](preview/micah_bell/1920x1080.png)|
|**John Marston**|**Lenny**|**Micah Bell**|
|![sadie-adler](preview/sadie_adler/1920x1080.png)|![simon-pearson](preview/simon_pearson/1920x1080.png)|![uncle](preview/uncle/1920x1080.png)|
|**Sadie Adler**|**Simon Pearson**|**Uncle**|

# **Installation**

There are many ways to install this theme. 

## Prerequisites

Required packages:
* [git](https://github.com/git-guides/install-git) 


### Installing git

#### debian/ubuntu (apt)
```Bash
$ sudo apt-get update
$ sudo apt-get install git
```
#### Fedora/CentOS

[dnf]
```Bash
$ sudo dnf install git
```
[yum]
```Bash
$ sudo yum install git
```

#### arch
```Bash
$ sudo pacman -S git

```


## **Installation via Script**

The script provides a nice Cli based prompt for simple installation of the themes, including multiple choice prompts and backgrounds, and the ability to create tarball based on different specifications.

<br>

### Cloning the repository
```Bash
$ git clone https://github.com/NAHDI51/rdr2-grub-theme.git
```

### Navigating to the cloned directory and Running the script
```Bash
cd rdr2-grub-theme
sudo chmod +x main.sh
./main.sh
```

Running this script, you'll be prompted to a multiple-choice based system, which is mostly self explanatory. upon completion, the theme will be installed in your system.

<br>

## **Installation via GRUB-Customizer**


Required packages
* [grub-customizer](https://www.javatpoint.com/grub-customizer-ubuntu)

### Installing grub-customizer


#### debian/ubuntu (apt)
```Bash
$ sudo add-apt-repository ppa:trebelnik-stefina/grub-customizer
$ sudo apt update
$ sudo apt install grub-customizer
```
#### Fedora/CentOS
[dnf]
```Bash
$ sudo dnf install grub-customizer
```
[yum]
```Bash
$ sudo yum install grub-customizer
```

#### Arch
```Bash
$ sudo pacman -S grub-customizer
```

### Cloning the repository
```Bash
$ git clone https://github.com/NAHDI51/rdr2-grub-theme.git
```
### Install a theme with GURB Customizer

* Open grub customizer. Type
```Bash
$ sudo grub-customizer
```
* Click on the **Appearance settings** tab
* Enable *custom resolution* and select your resolution, e.g 3840x2160
* Press the *add theme* button, then navigate to the directory where you cloned. Afterwards, navigate to themes. In other words, navigate to
```Bash
$DIR/rdr2-grub-theme/themes
```
* Click on the archive file you want you want. In other words, click on
```Bash
{$CHARACTER_NAME}.tar.gz
```
* Reboot your system and enjoy.
```Bash
systemctl reboot
```

## **Manual Installation**
<hr><br>

The most complicated one, but not hard nonetheless.

### Clone the repository and navigate to it.
```Bash
git clone https://github.com/NAHDI51/rdr2-grub-theme.git && cd rdr2-grub-theme
```

### Copy the theme folder to the grub themes folder
```Bash
sudo cp -a create/$(CHARACTER_NAME) /usr/share/grub/themes
```
Replace `$(CHARACTER_NAME)` with the name of the character theme you want to install.

### Edit grub configuration file
```Bash
sudo nano /etc/default/grub
```
And add the line: 
```Bash
GRUB_THEME="/usr/share/grub/themes/$(CHARACTER_NAME)/theme.txt"
```
Again, replace `$(CHARACTER_NAME)` with the name of the character theme you want to the install.

If there are any other instances of `GRUB_THEME` variable, be sure to comment it. 
```Bash
# GRUB_THEME="path/to/another/theme"
```

### Update grub

Create a script and enter to edit it. 
```Bash
touch grub-update.sh
nano grub-update.sh
```

Add the following lines in the file:
```Bash
#!/bin/bash

# checks whether a command is available
function has_command() {
  command -v $1 > /dev/null
}

# Updates the grub
grub-update() {
    if has_command update-grub; then
        update-grub
    elif has_command grub-mkconfig; then
        grub-mkconfig -o /boot/grub/grub.cfg
    elif has_command grub2-mkconfig; then
        if has_command zypper; then
            grub2-mkconfig -o /boot/grub2/grub.cfg
        elif has_command dnf; then
        grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
        fi
    fi
}

grub-update
```

Run this script.
```Bash
sudo chmod +x grub-update.sh
./grub-update.sh
```
And the theme is installed in your system.

