cp ~/projects/dotfiles/logitech-marble-mouse/wayland/99-logitech-marble-middle.hwdb /etc/udev/hwdb.d/99-logitech-marble-middle.hwdb

systemd-hwdb update
udevadm trigger

cp ~/projects/dotfiles/logitech-marble-mouse/wayland/local-overrides.quirks /etc/libinput/

echo "reboot in order to work"
