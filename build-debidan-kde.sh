#!/bin/bash
# Debian KDE ISO build script using live-build
# Tested on Debian 12 (Bookworm)

set -e

# 1. Make working directory
WORKDIR=~/debian-live-kde
mkdir -p $WORKDIR
cd $WORKDIR

# 2. Clean previous builds (if any)
sudo lb clean --purge || true

# 3. Configure live-build
lb config \
    --distribution bookworm \
    --debian-installer live \
    --debian-installer-gui true \
    --archive-areas "main contrib non-free non-free-firmware" \
    --bootappend-live "boot=live components username=user" \
    --tasks "kde-desktop"

# 4. Add custom packages (optional)
mkdir -p config/package-lists
cat <<EOF > config/package-lists/custom.list.chroot
vlc
build-essential   # compilers (gcc/g++, make, etc.)
git               # version control
curl              # HTTP requests from terminal
wget              # download utility
unzip zip         # archive tools
htop              # system monitor
vim nano          # text editors
nodejs            # JavaScript runtime
npm               # Node package manager
yarn              # Alternative package manager (optional)
python3           # Python (common for scripting & web dev)
python3-pip       # Python package manager
openjdk-17-jdk    # Java (common in enterprise web dev)
sqlite3           # lightweight DB
docker.io         # Docker containers
docker-compose    # Multi-container setups
gparted           # Disk partitioning GUI
kate              # KDE text editor
flatpak
gnome-software-plugin-flatpak

EOF


# 6. Build the ISO
echo ">>> Building Debian KDE ISO (this may take a while)..."
sudo lb build

echo ">>> Build finished!"
echo "Your ISO should be here: $WORKDIR/debian-live-*.hybrid.iso"

