#!/bin/bash

error() {
    echo -e "\033[32m${1}\033[39m"
    exit 1
}


chromium_location=$(which chromium)
[[ -z "$chromium_location" ]] && error "Could not locate the original Chromium binary in your PATH."
echo "Found Chromium at ${chromium_location}."

[[ -f "/usr/local/bin/chromium" ]] && error "/usr/local/bin/chromium already exists. This script writes to that file."

sudo tee /usr/local/bin/chromium > /dev/null <<EOF
#!/bin/sh
exec "$chromium_location" --password-store=basic "\$@"
EOF

sudo chmod +x /usr/local/bin/chromium

echo "Finished!"

