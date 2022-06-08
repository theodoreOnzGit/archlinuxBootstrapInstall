# archlinuxBootstrapConfig
A collection of config files to help with arch bootstrap while installing arch from manjaro

## Purpose

Installing Arch Linux is challenging as it is.

Of the many methods to use to install Arch Linux, 
I have chosen to install it from my 
[existing](https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux) 
linux manjaro distribution.

1. Why bootstrap and not a liveCD?

Because I have a working GUI, web browser and network to search through
all the Arch Linux Documentation I need.

There is also a method to use [a live cd image](https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux#Method_B:_Using_the_LiveCD_image)
 to install arch. Unfortunately, you kind of need to know how to
 unsquash an image and mount it properly in order to use it.

 This means we download the iso image, extract the contents and
 mount it directly rather than boot into the liveCD.

 Can be quite a steep elarning curve. So i'd rather avoid that.

## Downloading and Setting Up the Bootstrap Environment For Arch-Chroot

1. First it's important to [download](https://archlinux.org/download/)
 the bootstrap environment.
Just click on any mirror and start downloading the bootstrap tar.gz
file straightaway.

- [archlinux-bootstrap-2022.06.01-x86_64.tar.gz](http://mirror.arizona.edu/archlinux/iso/2022.06.01/archlinux-bootstrap-2022.06.01-x86_64.tar.gz)
- This is the example of one in 1st jun 2022. 
- Supposing the image is safe, use:
```zsh
sudo tar xzf <path-to-bootstrap-image>/archlinux-bootstrap-*-x86_64.tar.gz --numeric-owner
```
- next, mount the system using sudo, this is to help pacman install packages [properly](https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux#Downloading_basic_tools)

```zsh
sudo mount --bind directory-to-livecd-or-bootstrap directory-to-livecd-or-bootstrap
```

For a bootstrap, just navigate to the folder where your tar
file is and you ran the xzf command and run:
```zsh
sudo mount --bind ./root.x86_64/ ./root.x86_64/
```

2. Setting up pacman mirrors

Now, this bootstrap environment doesn't have vim or any nice color schemes.
So it's important to install these things before we start.

It doesn't even have pacman setup properly.

Hence, we will want to setup pacman first, especially the mirrors
as some mirrors will be outdated and will cause key signing errors.

The traditional way is to go to pacman-mirrors and uncomment them using
vim.

```zsh
sudo vim ./etc/pacman.d/mirrorlist
```

You would then uncomment the lines here and be done with it. However, 
try that and you would most certainly run into key signing errors.

Rather, go to [arch linux mirrors](https://archlinux.org/mirrorlist/), 
setup the mirror list and then copy and paste it into your mirrorlist 
file.

## Arch-Chroot and Setup Pacman
Once you've setup the archlinux bootstrap environment, and mirrors,

Once that is done, run:

```zsh
sudo ./root.x86_64/bin/arch-chroot ./root.x86_64/ 
```

You are actually running the binary arch-chroot which is in the 
bootstrap environment.

What this does is that it makes you the root user as using the
bootstrap root directory as your root directory.

To exit out of chroot, use
```zsh
exit
```

Once you're comfortable, start setting up pacman.

```zsh
pacman-key --init
pacman-key --populate
pacman -Syyu
```

Now of course, the terminal looks very ugly. There's no vim, and you
can't really do much here.

## Scripts for Quality of life improvements

To make the terminal a little nicer and to enable vim usage,






























