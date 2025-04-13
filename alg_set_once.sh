#!/bin/sh

# Check the current desktop environment
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    # Apply GNOME-specific settings
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.Console use-system-font false
    gsettings set org.gnome.Console custom-font 'Monospace 11'

    # Set GNOME Terminal profile font settings
    PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/" use-system-font false
    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/" font 'Monospace 11'

else
    # Copy calamares.desktop to Desktop for non-GNOME environments
    cp /usr/share/applications/calamares.desktop /home/liveuser/Desktop/calamares.desktop

    # Make calamares.desktop executable
    chmod +x /home/liveuser/Desktop/calamares.desktop

    # For XFCE, set calamares.desktop as trusted
    if [ "$XDG_CURRENT_DESKTOP" = "XFCE" ]; then
        for f in /home/liveuser/Desktop/calamares.desktop; do
            gio set -t string "$f" metadata::xfce-exe-checksum "$(sha256sum "$f" | awk '{print $1}')"
        done
    fi
fi

# Remove the autostart files
rm -f ~/.config/autostart/alg_set_once.desktop ~/.config/autostart/alg_set_once.sh
