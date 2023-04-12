#!/bin/sh
echo -ne '\033c\033]0;TestandoGodot\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DodgeGame.x86_64" "$@"
