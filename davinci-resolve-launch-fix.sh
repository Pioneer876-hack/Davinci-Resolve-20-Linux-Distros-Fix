#!/bin/bash

# Done by: Orient Manning (CyberDeadpool)
# Credits:
# Youtuber: https://www.youtube.com/@LinuxIsForAll
# RileyMeta on https://forum.blackmagicdesign.com/viewtopic.php?f=21&t=203100

# Fresh install DaVinci Resolve 20 fix 

# Greetings
echo -e "Script for Arch Linux DaVinci Resolve"

# Important note to user
echo -e "Check installation to make sure it's your Distro command to be on the safe side"

# Check for privilege before executing script
sudo_adder(){

    if [ "$EUID" -ne 0 ]; then
	    echo -e "Please run this script as root (e.g., with sudo)"
		exit 1
	fi

}

# Privilege check
sudo_adder

# Removing bad/dead files function
remove_files() {
    # Assigned a variable with a shell 
    change_dir="$(cd /opt/resolve/libs)"

    # Calling directory change variable
    $change_dir
    sleep 1.0

    # Remove bad/dead libraries 
    echo -e "Removing bad/dead libraries now...."
    rm -rf libgio-2.0.so libgio-2.0.so.0 libgio-2.0.so.0.6800.4 libglib-2.0.so libglib-2.0.so.0 libglib-2.0.so.0.6800.4 libgmodule-2.0.so libgmodule-2.0.so.0 libgmodule-2.0.so.0.6800.4 
    sleep 1.0 

    home_dir="$(cd ~)"

    $home_dir
    sleep 1.0

    echo -e "Installing missing library on Arch Linux"
}

echo -e "Running scripting..."

# Display distro choices to user:
distro_display(){
    echo -e "\n1. Arch Linux Distros"
    echo -e "\n2. Debian/Ubuntu Distros"
    echo -e "\n3. RHEL-based Distros (RHEL, CentOS, Fedora, AlmaLinux, Rocky Linux)"
    echo -e "\n4. openSUSE and SUSE Linux Enterprise (SLE)"
    echo -e "\n5. Solus"
    echo -e "\n6. Void Linux"
    echo -e "\n7. Gentoo Linux"
    echo -e "\n8. Slackware"
    echo -e "\n9. NixOS"
    echo -e "\n10. Alpine Linux"
    echo -e "\n11. Clear Linux"
}

# Call distro options 
distro_display

# Starting installation display message
starting_installation() {
    echo -e "Starting installation..."
    sleep 1.0
}

# CTRL-C Keybind End
ctrl_c(){
	trap 'echo -e "\n🚫 scan interrupted. Exiting..."; exit' SIGINT
}

# Get user input function
check_distro() {
    # Call function and assign to a variable
    distro=$(distro_display)
    
    read -p "Distro choice (1 or 2): " distro

    case "$distro" in
    1)
         # Arch Linux
        starting_installation
        pacman -S libxcrypt-compat
    ;;

    2)
        # Debian/Ubuntu
        starting_installation
        apt install libxcrypt-compat
    ;;

    3) 
        # RHEL-based Distros (RHEL, CentOS, Fedora, AlmaLinux, Rocky Linux)
        echo -e "Examples: sudo yum install <package> (older) and sudo dnf install <package> (newer)"
        read -p "Are you running older or newer RHEL-based Distros (RHEL, CentOS, Fedora, AlmaLinux, Rocky Linux)? " RHEL

        # Check if Distro is older or newer
        if [ "$RHEL" == "older" ]; then
            starting_installation
            yum install libxcrypt-compat
        
        elif [ "$RHEL" == 'newer' ]; then
            starting_installation
            dnf install libxcrypt-compat
        fi
    ;;

    4)
        # openSUSE and SUSE Linux Enterprise (SLE)
        starting_installation
        zypper addrepo https://download.opensuse.org/repositories/Base:System/openSUSE_Tumbleweed/Base:System.repo
        zypper refresh
        zypper install libxcrypt-compat
    ;;

    5)
        # Solus
        starting_installation
        eopkg install libxcrypt-compat
    ;;

    6)
        # Void Linux
        starting_installation
        xbps-install -S libxcrypt libxcrypt-compat
    ;;

    7)
        # Gentoo Linux
        starting_installation
        emerge --sync
        emerge sys-libs/libxcrypt
    ;;

    8)
        # NixOS
        starting_installation
        nix-env -iA nixpkgs.libxcrypt
    ;;

    9)
        # Alpine Linux
        starting_installation
        apk add libxcrypt-compat
    ;;

    10) 
        # Clear Linux
        swupd bundle-add os-core-update
        starting_installation
        swupd bundle-add libxcrypt-compat
esac
}
check_distro

# CTRL-C Function
ctrl_c

# Call remove files function
remove_files

echo -e "Use this command in terminal -> /opt/resolve/bin/resolve or go to your menu and try to start Davinci Resolve again"
