
sudo apt install plymouth plymouth-themes

sudo apt install nvidia-driver firmware-misc-nonfree
sudo rm /usr/lib/udev/rules.d/61-gdm.rules 
sudo find / -iname MOK.*
sudo mkdir -p /var/lib/shim-signed/mok
sudo ln -s /var/lib/dkms/mok.key /var/lib/shim-signed/mok/MOK.priv
sudo ln -s /var/lib/dkms/mok.pub /var/lib/shim-signed/mok/MOK.der
sudo mokutil --test-key /var/lib/dkms/mok.pub
sudo mokutil --import /var/lib/dkms/mok.pub

sudo apt install xinput
sudo cp 01-xinput-disable.rules /etc/udev/rules.d/
sudo apt install openconnect network-manager-openconnect network-manager-openconnect-gnome
sudo apt install openconnect network-manager-openconnect network-manager-gnome

sudo apt install -f /tmp/google-chrome-stable_current_amd64.deb 
sudo apt install -f /tmp/onedriver_0.14.0-1_amd64.deb 

sudo apt install snapd
sudo snap install spotify keepassxc vlc
sudo snap install code --classic

sudo apt install -f /tmp/virtualbox-7.0_7.0.10-158379~Debian~bookworm_amd64.deb 
sudo usermod -a -G vboxusers marceloalm 

cd .ssh/
chmod 644 *
chmod 600 marceloalm@outlook.com.br.id_rsa 

sudo dpkg --add-architecture i386 
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
sudo apt update
sudo apt upgrade
sudo apt install winehq-staging winetricks git

sudo apt install -f /tmp/heroic_2.9.1_amd64.deb 
sudo apt install gamemode cabextract

alias ls='ls -la --color'
alias grep='grep -i --color'

wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
WINEPREFIX=$HOME/Games/Battle.net/ winecfg
WINEPREFIX=$HOME/Games/Battle.net/ ./winetricks corefonts
WINEPREFIX=$HOME/Games/Battle.net/ wine $HOME/Games/Battle.net/drive_c/Battle.net/Battle.net.exe 
WINEPREFIX=$HOME/Games/Battle.net/ ./winetricks corefonts dxvk
WINEPREFIX=$HOME/Games/Battle.net/ wine Battle.net-Setup.exe 

sudo apt install /tmp/steam_latest.deb 

which gnome-system-monitor
which gnome-terminal

sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.3 /usr/lib/libcrypto.so.6
/usr/bin/SACTools 

sudo apt install libnss3 libnss3-tools
modutil -dbdir sql:.pki/nssdb/ -add "eToken" -libfile /usr/lib/libeToken.so

sudo apt install gnome-session-canberra 

