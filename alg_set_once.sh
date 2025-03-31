#!/bin/sh

# For setting calamares.desktop as trusted in xfce
for f in ~/Desktop/calamares.desktop; do chmod +x "$f"; gio set -t string "$f" metadata::xfce-exe-checksum "$(sha256sum "$f" | awk '{print $1}')"; done

# Copy calamares.desktop to Desktop
cp /usr/share/applications/calamares.desktop /home/liveuser/Desktop/calamares.desktop
# Make calamares.desktop executable
chmod +x ~/Desktop/calamares.desktop

# Remove the contents
rm  ~/.config/autostart/alg_set_once.desktop ~/.config/autostart/alg_set_once.sh
