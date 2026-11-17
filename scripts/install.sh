#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
if [[ "${1:-}" == "--help" ]]; then
    echo "Usage: scripts/install.sh [--apt]"
    echo "--apt installs Ubuntu packages with sudo; otherwise only checks prerequisites."
    exit 0
fi
if [[ $# -gt 1 || ( $# -eq 1 && "$1" != "--apt" ) ]]; then
    echo "Unknown argument; use --help" >&2
    exit 1
fi
# shellcheck source=/dev/null
source /etc/os-release
[[ "$ID" == ubuntu ]] || { echo "This installer supports Ubuntu only." >&2; exit 1; }
if [[ "${1:-}" == "--apt" ]]; then
    sudo apt-get update
    sudo apt-get install -y build-essential cmake ninja-build git curl unzip tar gzip \
        ripgrep python3 python3-venv python3-pip \
        wl-clipboard xclip
fi
for tool in nvim git cc cmake ninja rg curl unzip python3 mise timeout; do
    command -v "$tool" >/dev/null || { echo "Missing prerequisite: $tool (see docs/setup.md)" >&2; exit 1; }
done
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/${NVIM_APPNAME:-nvim}"
[[ -d "$config_dir" && "$(cd -- "$config_dir" && pwd -P)" == "$repo_dir" ]] || {
    echo "Place or symlink this checkout at $config_dir before installing." >&2
    exit 1
}
cd -- "$repo_dir"
mise install node npm go rust
exec mise exec -- bash "$repo_dir/scripts/install-config.sh"
