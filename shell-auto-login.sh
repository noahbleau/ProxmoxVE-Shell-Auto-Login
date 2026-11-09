#!/bin/bash
# ProxmoxVE Shell Auto Login
# https://github.com/noahbleau/ProxmoxVE-Shell-Auto-Login
# Author(s): @noahbleau
# License: GPL-3.0 (see the LICENSE file for details)

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

