mkdir -p config/includes.chroot/etc/skel/.config/neofetch
cat <<'EOF' > config/includes.chroot/etc/skel/.bashrc
# Run Neofetch automatically if installed
if command -v neofetch >/dev/null 2>&1; then
    neofetch
fi
EOF

