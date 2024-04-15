# ~/.bashrc
#======================================================================================
#                               Arch Linux Bash Configuration
# Date    : 04/20/2024
# Author  : Travis Fleetwood	travis@cloudnexus.pro
# Version : v1
# License : Distributed under the terms of GNU GPL version 2 or later
#======================================================================================

# This script is a bash configuration file that is executed by the bash shell when it starts up,
# and is specifically for non-login shells. 
# The script is intended to configure various settings and environment variables for the shell,
# such as the command history, the editor, and the prompt.

############
### IBUS ###
############

# Ibus settings, if you need them.
# IBus (Intelligent Input Bus) is an input method framework for multilingual input in Unix-like operating systems.
# It aims to provide a flexible and extensible framework for input methods,
# which can be used to input complex scripts, such as Chinese, Japanese, Korean, and more.
# With IBus, users can switch between different input methods on-the-fly,
# without having to restart their applications.
# This makes it very convenient for users who frequently switch between languages or scripts.
# The lines in the script you provided are related to the IBus input method system.
# They can be used to configure and start the Ibus daemon.
# Type "ibus-setup" in the terminal to change settings and start the daemon.

# Uncomment the following lines and restart.
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus


###################################################
### SHELL CONFIGURATION & ENVIRONMENT VARIABLES ###
###################################################

# Check if shell is running interactively, and if it is not, do not do anything.
[[ $- != *i* ]] && return

# Start the ssh-agent and set the needed environmental variables when a new interactive shell is  launched.
eval $(ssh-agent)

# Kill the ssh-agent process on shell exit
trap "ssh-agent -k" EXIT

# The line export HISTCONTROL=ignoreboth:erasedups configures command history to ignore duplicates,
# commands starting with space,
# and removes previous commands that are the same as the current command before saving it.
export HISTCONTROL=ignoreboth:erasedups

# Make nano the default editor.
export EDITOR='nano'
export VISUAL='nano'

# Color variables.
PURPLE=$(tput setaf 165)
CYAN=$(tput setaf 006)
GREEN=$(tput setaf 10)
WHITE=$(tput setaf 15)
YELLOW=$(tput setaf 11)
GREY=$(tput setaf 007)
ORANGE=$(tput setaf 202)
RED=$(tput setaf 001)
PINK=$(tput setaf 206)
RESET=$(tput sgr0)

# Adds the directories $HOME/.bin and $HOME/.local/bin to the PATH variable,
# so that the executables in these directories can be run from anywhere,
# without specifying the full path of the executable.

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

# Ignores upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# Shopt session options.
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases

# Check if the "neofetch" and "lolcat" packages can be found on the system, and install them ony if they are not.
if ! command -v neofetch > /dev/null; then
  echo "neofetch not found, installing..."
  sudo pacman -S neofetch
fi

if ! command -v lolcat > /dev/null; then
  echo "lolcat not found, installing..."
  sudo pacman -S lolcat
fi

# Reporting tools - install when not installed.
neofetch | lolcat

# Create a file called .bashrc-personal and put all your personal aliases in there.
# They will not be overwritten by skel.
[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal

# Define a CoinMarketCap API key
export COINMARKETCAP_API_KEY="7dac2326-def0-4b2e-89d0-ca8a744b26be"


###########
### PS1 ###
###########

# Original Prompt Script 1
#PS1='[\u@\h:\W]\$ '

# Previous Custom PS1 to the active PS1.
# PS1="\[\033[35m\]\@\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[m\]:\[\033[33;1m\]\w\[\033[30m\]\$ "

# Active PS1.
PS1="\[$PURPLE\]\@"
PS1+="\[$GREY\]-"
PS1+="\[$CYAN\]\u"
PS1+="\[$GREY\]@"
PS1+="\[$ORANGE\]\h"
PS1+="\[$GREY\]:"
PS1+="\[$YELLOW\]\w"
PS1+="\`if [ \$? = 0 ]; then echo \[$GREEN\]$\[\e[0m\]; else echo \[$RED\]$\[\e[0m\]; fi\`"
PS1+="\[$RESET\] "

export PS1


###############
### ALIASES ###
###############

# List.
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='lsd -alh'
alias l='ls'
alias l.="ls -A | egrep '^\.'"



# Colorize the grep command output for ease of use (good for log files).
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# The command df -h is used to display the available and used disk space on the file system
# in a human-readable format, including the size of the file system, the space used, the space available,
# the percentage used, and the mount point.
alias df='df -h'

# Switch to the QUERTY-US keyboard.
alias give-me-qwerty-us="sudo localectl set-x11-keymap us"

# A lock file is a type of flag file that is used to ensure that only one process is accessing a resource at a time.
# In pacman, it is used to ensure that only one instance of pacman is running at a time, to avoid conflicts and corruption of the package database.
# This command should be used with caution, as it can cause problems with pacman's database and it's possible to corrupt the package database if multiple instances of pacman are running simultaneously.
# This command is used to remove the lock file located at /var/lib/pacman/db.lck.
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias rmpacmanlock="sudo rm /var/lib/pacman/db.lck"


# This lock file is used to ensure that only one instance of logout process is running at a time.
# This command should be used with caution,
# as it could cause problems with the logout process if multiple instances of logout are running simultaneously.
# This command is used to remove the logout lock file located at /tmp/arcologout.lock.
alias rmlogoutlock="sudo rm /tmp/arcologout.lock"

# Find out which graphical card is working.
alias whichvga="/usr/local/bin/arcolinux-which-vga"

# The command free -mt is used to display the amount of free and used memory (RAM) in the Linux system, in MB,
# and also display a total line at the end of the output.
alias free="free -mt"

# The command wget -c is used to download files from the internet using the command line,
# with the option -c to continue a previously-interrupted download.
# This is useful if the download was interrupted for some reason,
# and you want to resume it from where it left off, rather than starting the download from the beginning.
# This alias will automatically continue the download if one was already going.
alias wget="wget -c"

# This alias will produce a clean userlist.
alias userlist="cut -d: -f1 /etc/passwd"

# Merge and load the X resources database for the X Window System.
alias merge="xrdb -merge ~/.Xresources"

# Aliases for software managment
# pacman or pm
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syu'

# Update everything alais.
alias upall="paru -Syu --noconfirm"

# Displays information about the currently running processes. 
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

# Updates the grub configuration file.
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Add new fonts.
alias update-fc='sudo fc-cache -fv'

# Copy/paste all content of /etc/skel over to home folder - backup of config created - beware.
alias skel='[ -d ~/.config ] || mkdir ~/.config && cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~'
#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

# Copy bashrc-latest over on bashrc - cb= copy bashrc.
alias cb='sudo cp /etc/skel/.bashrc ~/.bashrc && source ~/.bashrc'
#copy /etc/skel/.zshrc over on ~/.zshrc - cb= copy zshrc
#alias cz='sudo cp /etc/skel/.zshrc ~/.zshrc && exec zsh'

# Switch between bash and zsh.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

# Switch between lightdm and sddm.
alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"
alias toly="sudo pacman -S ly --noconfirm --needed ; sudo systemctl enable ly.service -f ; echo 'Ly is active - reboot now'"
alias togdm="sudo pacman -S gdm --noconfirm --needed ; sudo systemctl enable gdm.service -f ; echo 'Gdm is active - reboot now'"
alias tolxdm="sudo pacman -S lxdm --noconfirm --needed ; sudo systemctl enable lxdm.service -f ; echo 'Lxdm is active - reboot now'"

# Quickly kill conkies
alias kc='killall conky'
# Quickly kill polybar
alias kp='killall polybar'

# Hardware info (short).
alias hw="hwinfo --short"

# Skip integrity check.
alias paruskip='paru -S --mflags --skipinteg'
alias yayskip='yay -S --mflags --skipinteg'
alias trizenskip='trizen -S --skipinteg'

# Check for vulnerabilities in the microcode.
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

# YouTube download aliases.
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

# Recent Installed Packages.
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

# Iso and version used to install ArcoLinux.
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

# Cleanup orphaned packages with pacman.
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Search content with ripgrep.
alias rg="rg --sort path"

# Get the error messages from journalctl.
alias jctl="journalctl -p 3 -xb"

# Aliases for files that need edits often, using the nano text editor.
alias nlxdm="sudo $EDITOR /etc/lxdm/lxdm.conf"
alias nlightdm="sudo $EDITOR /etc/lightdm/lightdm.conf"
alias npacman="sudo $EDITOR /etc/pacman.conf"
alias ngrub="sudo $EDITOR /etc/default/grub"
alias nconfgrub="sudo $EDITOR /boot/grub/grub.cfg"
alias nmkinitcpio="sudo $EDITOR /etc/mkinitcpio.conf"
alias nmirrorlist="sudo $EDITOR /etc/pacman.d/mirrorlist"
alias narcomirrorlist='sudo nano /etc/pacman.d/arcolinux-mirrorlist'
alias nsddm="sudo $EDITOR /etc/sddm.conf"
alias nsddmk="sudo $EDITOR /etc/sddm.conf.d/kde_settings.conf"
alias nfstab="sudo $EDITOR /etc/fstab"
alias nnsswitch="sudo $EDITOR /etc/nsswitch.conf"
alias nsamba="sudo $EDITOR /etc/samba/smb.conf"
alias ngnupgconf="sudo nano /etc/pacman.d/gnupg/gpg.conf"
alias nb="$EDITOR ~/.bashrc"
alias nz="$EDITOR ~/.zshrc"

# Gnu Privacy Guard key pair aliases.
# Verify signature for isos.
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
alias fix-gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"
alias fix-keyserver="[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

# Aliases for fixes.
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias keyfix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias key-fix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias keys-fix="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fixkey="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fixkeys="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-key="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-keys="/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
alias fix-sddm-config="/usr/local/bin/arcolinux-fix-sddm-config"
alias fix-pacman-conf="/usr/local/bin/arcolinux-fix-pacman-conf"
alias fix-pacman-keyserver="/usr/local/bin/arcolinux-fix-pacman-gpg-conf"

# Aliases for maintenance.
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias downgrada="sudo downgrade --ala-url https://ant.seedhost.eu/arcolinux/"

# Systeminfo aliases.
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

# Shutdown or reboot aliases.
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# Update betterlockscreen images.
alias bls="betterlockscreen -u /usr/share/backgrounds/arcolinux/"

# Give the list of all installed desktops - xsessions desktops.
alias xd="ls /usr/share/xsessions"

# Arcolinux applications aliases.
alias att="arcolinux-tweak-tool"
alias abl="arcolinux-betterlockscreen"

# Remove the git cache alias.
alias rmgitcache="rm -r ~/.cache/git"

# Alias to move your personal files and folders from /personal to ~.
alias personal='cp -Rf /personal/* ~'

