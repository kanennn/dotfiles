# dotfiles

## Opinions

- Spacious and easy to navigate
- Wallpaper adaptive colorscheme
- Based in Hyprland on Arch (ARM)
- Seamless consistent experience -> high fidelity (no unfinished sections or areas with inconsistent style)
- Cozy bordered + widgets style

## Software

### Core
- Arch Linux ARM (ALARM Asahi)

### Desktop
- Hyprland
- sddm (need to customize)
- grub2 (need to customize)
- Quickshell
- wofi
- hyprpaper
- dunst 
- lxappearance
- FiraCodeNerdFont
- pavucontrol

### System Utils
- upower
- pipewire (/pipe-wire-pulse)
- bluez (bluetooth) 
- xdg-desktop-portal (& xdg-desktop-portal-hyprland)
- brightnessct
- iwd (as networkmanager backend)
- xorg-xwayland (specifically for x11 forwarding over ssh)
- wl-clipboard

### User Utils

- rustup
- gcc
- cargo
- wiregaurd
- lua
- luarocks
- rustfmt

### CLI stuff

- zsh + ohmyzsh
- nvim
- emacs
- fastfetch
- nnn (term file manager)
- cage (to run independent gui applications)
- yay (for aur helper)
- stow (for dotfiles
- ImageMagick
- rustic-rs 
- dua-cli (disk usage viewer)
- btop (CPU usage stats)
- typst 
- zathura (viewer)
- ttyper (typing test)
- hyprshot
- grim
- slurp
- zmv


### GUI Applications

- Librewolf (flatpak)
- Vesktop (flatpak)
- Obsidian (flatpak)
- thunderbird (native)

# Manual Setup

- Install packages
- Enable notch
- Add/stow dotfiles (make sure to use --dotfiles!!)
- Configure grub startup
- make sure iwd is networkmanager backend
- Configured GTK and QT themes using gsettings or config files (config more consistent??)
- Install applications (Flatpak)

# Todo

- [x] Change all directories to have a "dot-" prefix instead of using hidden folders, along with using GNU Stow --dotfiles
- [ ] Customize grub
- [ ] Configure nvim (wip)
- [ ] Custom zsh config (versus oh-my-zsh)
- [ ] Custom kitty config (at least learn lol) (wip)
- [ ] Organize all this stuff
- [ ] Make a streamlined package list that can be installed automatically
- [ ] Complete and consolidate current goals and then make a tag release for *eclipse* and then set goals for next iteration
