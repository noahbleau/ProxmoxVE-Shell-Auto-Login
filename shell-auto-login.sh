#!/bin/bash
# ProxmoxVE Shell Auto Login
# https://github.com/noahbleau/ProxmoxVE-Shell-Auto-Login
# Author(s): @noahbleau
# License: GPL-3.0 (see the LICENSE file for details)

# Define the repository URL of this script
GIT_URL="https://github.com/noahbleau/ProxmoxVE-Shell-Auto-Login"

# Define variables used for coloring the output
# Usage: ${COLORS[COLOR_NAME]} to apply color, ${COLORS[RESET]} to reset color
declare -A COLORS
COLORS=(
	[RESET]='\033[0m'
	[RED]='\033[0;31m'
	[GREEN]='\033[0;32m'
	[BLUE]='\033[0;34m'
	[YELLOW]='\033[0;33m'
	[PURPLE]='\033[0;35m'
	[CYAN]='\033[0;36m'
)

# Display warnings and information about the script's development status and reporting issues
echo -e "${COLORS[YELLOW]}[WARN] This script is still under development, do not use this script in production${COLORS[RESET]}"
echo -e "${COLORS[YELLOW]}[WARN] If you are part of the entreprise licensing, do not use this script as it could violate your licensing agreement${COLORS[RESET]}"
echo -e "${COLORS[BLUE]}[INFO] If any bugs or issues are encountered, please report them on the GitHub repository as a new issue:${COLORS[RESET]}"
echo -e "${COLORS[BLUE]}       ${GIT_URL}/issues/new${COLORS[RESET]}\n"

# Verify that the system is Proxmox Virtual Environment (Proxmox VE)
if ! (uname -r 2>/dev/null | grep -q "pve"); then
	echo -e "${COLORS[RED]}[ERROR] This system does not appear to be ProxmoxVE, this script is only for ProxmoxVE systems${COLORS[RESET]}"
	echo -e "${COLORS[RED]}Exiting script due to errors...${COLORS[RESET]}"
	exit 1
fi

# Store the current logged in user
# This will store the username of the user who invoked sudo, or the current user if not using sudo.
# This ensures that the script knows which user is currently active, even if running with elevated privileges.
USER=${SUDO_USER:-$(whoami)}

# Prevent running the script with root since ProxmoxVE Shell Auto Login is already active
# for root by default on ProxmoxVE installations
if [[ $USER == "root" ]]; then
	echo -e "${COLORS[RED]}[ERROR] This script should not be run as root${COLORS[RESET]}"
	echo -e "${COLORS[BLUE]}[INFO] ProxmoxVE Shell Auto Login is already active for root by default on ProxmoxVE installations${COLORS[RESET]}"
	echo -e "${COLORS[RED]}Exiting script due to errors...${COLORS[RESET]}"
	exit 1
fi

# Verify that the script is being run with sudo
# Check if the effective user ID is not root (0)
if [[ $EUID -ne 0 ]]; then
	echo -e "${COLORS[RED]}[ERROR] This script must be run with sudo${COLORS[RESET]}"
	echo -e "${COLORS[RED]}Exiting script due to errors...${COLORS[RESET]}"
	exit 1
fi