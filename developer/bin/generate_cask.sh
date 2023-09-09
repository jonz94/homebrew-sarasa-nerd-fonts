#!/bin/bash

root=$(cd $(dirname $0) && cd .. && cd .. && pwd)
tmp="${root}/tmp"

mkdir -p $tmp

# get latest version
version=$(curl -fsSL "https://api.github.com/repos/jonz94/Sarasa-Gothic-Nerd-Fonts/releases/latest" | grep tag_name | cut -d '"' -f 4 | cut -d v -f 2)

styles=(    "fixed" "fixed-slab" "mono" "mono-slab" "term" "term-slab" "gothic" "ui")
stylesName=("Fixed" "Fixed Slab" "Mono" "Mono Slab" "Term" "Term Slab" "Gothic" "UI")

orthographies=(    "cl" "hc" "j" "k" "sc" "tc")
orthographiesName=("CL" "HC" "J" "K" "SC" "TC")

for i in ${!styles[@]}; do
  for j in ${!orthographies[@]}; do
    name="sarasa-${styles[$i]}-${orthographies[$j]}"
    url="https://github.com/jonz94/Sarasa-Gothic-Nerd-Fonts/releases/download/v${version}/${name}-nerd-font.zip"

    echo "Downloading ${name}-nerd-font.zip to compute hashes!"

    # silent mode if script is running by Github Actions
    if [[ "${GITHUB_ACTIONS}" == "true" ]]; then
      curl --silent --fail -L $url -o "${tmp}/${name}.zip"
    else
      curl --progress-bar --fail -L $url -o "${tmp}/${name}.zip"
    fi

    sha256=$(sha256sum "${tmp}/${name}.zip" | cut -f 1 -d " ")
    echo "Computed hash: ${sha256}"

    echo "Writing font-${name}-nerd-font cask"

    cask=$(cat <<EOF
cask "font-${name}-nerd-font" do
  version "${version}"
  sha256 "${sha256}"

  url "https://github.com/jonz94/Sarasa-Gothic-Nerd-Fonts/releases/download/v#{version}/${name}-nerd-font.zip"
  name "Sarasa ${stylesName[$i]} ${orthographiesName[$j]} Nerd Fonts"
  desc "CJK programming font based on Iosevka and Source Han Sans (Nerd Fonts patched)"
  homepage "https://github.com/jonz94/Sarasa-Gothic-Nerd-Fonts"

  font "${name}-bold-nerd-font.ttf"
  font "${name}-bolditalic-nerd-font.ttf"
  font "${name}-extralight-nerd-font.ttf"
  font "${name}-extralightitalic-nerd-font.ttf"
  font "${name}-italic-nerd-font.ttf"
  font "${name}-light-nerd-font.ttf"
  font "${name}-lightitalic-nerd-font.ttf"
  font "${name}-regular-nerd-font.ttf"
  font "${name}-semibold-nerd-font.ttf"
  font "${name}-semibolditalic-nerd-font.ttf"
end
EOF
)

    file="${root}/Casks/font-${name}-nerd-font.rb"
    printf "${cask}" > $file
    echo >> $file
  done
done

