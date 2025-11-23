#!/bin/bash

ascii_art='
▄▄▄▄  ▄ ▄▄▄▄  ▄  ▄▄▄ ▄▄▄  ▄▄▄▄
█ █ █ ▄ █ █ █ ▄ █   █   █ █   █
█   █ █ █   █ █ █   ▀▄▄▄▀ █   █
      █       █                 '

colors=(
	'\033[38;5;210m' # Rosewater/Pink
	'\033[38;5;222m' # Peach
	'\033[38;5;229m' # Yellow
	'\033[38;5;158m' # Green
)

# Split the ASCII art into lines (compatible with both bash and zsh)
lines=()
while IFS= read -r line; do
	lines+=("$line")
done <<< "$ascii_art"

# Print each line with the corresponding color
i=0
for line in "${lines[@]}"; do
	echo -e "${colors[$i]}${line}"
	i=$((i + 1))
done

# Reset color to default
echo -e '\033[0m'
