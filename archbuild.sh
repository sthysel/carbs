#!/bin/bash

# Bootstrap a new arch box
# $ curl https://raw.githubusercontent.com/sthysel/dotfiles/master/archbuild.sh | bash

dotfilesrepo="https://github.com/sthysel/dotfiles.git"
packages="https://raw.githubusercontent.com/sthysel/dotfiles/master/programs.csv"
aurhelper="packer"

main_user="bro2"

refresh_arch_keys() {
	  echo "Refreshing Arch Keyring..."
	  pacman --noconfirm -Sy archlinux-keyring &>/dev/null
}

add_user() {
	  pass1=$(dialog --no-cancel --passwordbox "Enter a password for ${main_user}." 10 60 3>&1 1>&2 2>&3 3>&1)
	  pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	  while ! [[ ${pass1} == ${pass2} ]]
    do
		    unset pass2
		    pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\n\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		    pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	  done

    echo "Adding user ${main_user}"
    useradd -m -g wheel -s /bin/bash ${main_user} &>/dev/null ||
    usermod -a -G wheel ${main_user}
    echo "$name:$pass1" | chpasswd
    unset pass1 pass2
}

git_install() {
    #local repo=${1}
	  dir=$(mktemp -d)

	  echo "Installing \`$(basename $1)\` ($n of $total) via \`git\` and \`make\`. $(basename $1) $2."
	  git clone --depth 1 "$1" $dir &>/dev/null
	  cd $dir
	  make &>/dev/null
	  make install &>/dev/null
	  cd /tmp
}

pacmman_install() {
	  echo "Installing \`$1\` ($n of $total). $1 $2."
	  pacman --noconfirm --needed -S "$1" &>/dev/null
}

aur_install() {
	  echo "Installing \`$1\` ($n of $total) from the AUR. $1 $2."
	  grep "^$1$" <<< "$aurinstalled" && return
	  sudo -u ${main_user} $aurhelper -S --noconfirm "$1" &>/dev/null
}

install_packages_from_csv() {
	  ([ -f "$packages" ] && cp "$packages" /tmp/packages.csv) || curl -Ls "$packages" > /tmp/packages.csv
	  total=$(wc -l < /tmp/packages.csv)
	  aurinstalled=$(pacman -Qm | awk '{print $1}')
	  while IFS=, read -r tag program comment
    do
	      n=$((n+1))
	      case "$tag" in
	          "") pacman_install "$program" "$comment" ;;
	          "A") aur_install "$program" "$comment" ;;
	          "G") git_install "$program" "$comment" ;;
	      esac
	  done < /tmp/packages.csv
}

serviceinit() {
    for service in $@
    do
	      echo "Enabling \"$service\"..."
	      systemctl enable "$service"
	      systemctl start "$service"
	  done
}

newperms() {
    # Set special sudoers settings for install (or after).
	  sed -i "/#LARBS/d" /etc/sudoers
	  echo -e "$@ #LARBS" >> /etc/sudoers
}

systembeepoff() {
    echo "Disable error beep "
	  rmmod pcspkr
	  echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
}

# Downlods a gitrepo $1 and places the files in $2 only overwriting conflicts
putgitrepo() {
    local repo=${1}
    local target=${2}
	  echo "Downloading and installing config files..."
	  dir=$(mktemp -d)
	  chown -R $main_user:wheel $dir
	  sudo -u $main_user git clone --depth 1 $repo $dir/gitrepo &>/dev/null &&
        sudo -u $main_user mkdir -p "$target" &&
        sudo -u $main_user cp -rT $dir/gitrepo $target
}

resetpulse() {
    echo "Reseting Pulseaudio..."
	  killall pulseaudio && sudo -n $name pulseaudio --start
    # Pulseaudio, if/when initially installed, often needs a restart to work immediately.
}

manualinstall() {
    # Installs $1 manually if not installed. Used only for AUR helper here.
	  [[ -f /usr/bin/$1 ]] || (
	      echo "Installing \"$1\", an AUR helper..."
	      cd /tmp
	      rm -rf /tmp/$1*
	      curl -sO https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz &&
	          sudo -u ${main_user} tar -xvf $1.tar.gz &>/dev/null &&
	          cd $1 &&
	          sudo -u ${main_user} makepkg --noconfirm -si &>/dev/null
	      cd /tmp)
}

is_root() {
    if [[ $EUID -ne 0 ]]
    then
        echo "This script must be run as root"
        exit 1
    fi
}

# this is a new machine install, need to be root for that
is_root
add_user
refresh_arch_keys

# Allow user to run sudo without password. Since AUR programs must be installed in a fakeroot environment, this is required for all builds with AUR.
newperms "%wheel ALL=(ALL) NOPASSWD: ALL"

manualinstall $aurhelper

# The command that does all the installing. Reads the packages.csv file and
# installs each package the way required. Be sure to run this only after
# the user has been created and has priviledges to run sudo without a password
# and all build dependencies are installed.
install_packages_from_csv

# Install the dotfiles in the user's home directory
putgitrepo "$dotfilesrepo" "/home/$main_user"

# kick pulseaudio
[[ -f /usr/bin/pulseaudio ]] && resetpulse

# Install the LARBS Firefox profile in ~/.mozilla/firefox/
putgitrepo "https://github.com/LukeSmithxyz/mozillarbs.git" "/home/$name/.mozilla/firefox"


# Enable services here.
serviceinit NetworkManager cronie

systembeepoff

# This line, overwriting the `newperms` command above will allow the user to run
# serveral important commands, `shutdown`, `reboot`, updating, etc. without a password.
newperms "%wheel ALL=(ALL) ALL\n%wheel ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/reboot,/usr/bin/wifi-menu,/usr/bin/mount,/usr/bin/umount,/usr/bin/pacman -Syu,/usr/bin/pacman -Syyu,/usr/bin/packer -Syu,/usr/bin/packer -Syyu,/usr/bin/systemctl restart NetworkManager,/usr/bin/rc-service NetworkManager restart, /usr/bin/pacman -Syyu --noconfirm"

finalize
clear
