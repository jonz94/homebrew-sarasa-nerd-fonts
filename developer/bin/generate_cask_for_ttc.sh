#!/bin/bash

root=$(cd $(dirname $0) && cd .. && cd .. && pwd)
tmp="${root}/tmp"

mkdir -p $tmp

# get latest version
version=$(curl -fsSL "https://api.github.com/repos/jonz94/ttc-sarasa-gothic-nerd-fonts/releases/latest" | grep tag_name | cut -d '"' -f 4 | cut -d v -f 2)

url="https://github.com/jonz94/ttc-sarasa-gothic-nerd-fonts/releases/download/v${version}/sarasa-nerd-font-ttc.zip"

echo "Downloading sarasa-nerd-font-ttc.zip to compute hashes!"

# silent mode if script is running by Github Actions
if [[ "${GITHUB_ACTIONS}" == "true" ]]; then
  curl --silent --fail -L $url -o "${tmp}/sarasa-nerd-font-ttc.zip"
else
  curl --progress-bar --fail -L $url -o "${tmp}/sarasa-nerd-font-ttc.zip"
fi

sha256=$(sha256sum "${tmp}/sarasa-nerd-font-ttc.zip" | cut -f 1 -d " ")
echo "Computed hash: ${sha256}"

echo "Writing font-sarasa-nerd-font-ttc cask"

cask=$(cat <<EOF
cask "font-sarasa-nerd-font-ttc" do
  version "${version}"
  sha256 "${sha256}"

  url "https://github.com/jonz94/ttc-sarasa-gothic-nerd-fonts/releases/download/v#{version}/sarasa-nerd-font-ttc.zip"
  name "Sarasa Gothic Nerd Fonts TTC"
  desc "CJK programming font based on Iosevka and Source Han Sans (Nerd Fonts patched)"
  homepage "https://github.com/jonz94/Sarasa-Gothic-Nerd-Fonts"

  font "sarasa-bold-nerd-font.ttc"
  font "sarasa-bolditalic-nerd-font.ttc"
  font "sarasa-extralight-nerd-font.ttc"
  font "sarasa-extralightitalic-nerd-font.ttc"
  font "sarasa-italic-nerd-font.ttc"
  font "sarasa-light-nerd-font.ttc"
  font "sarasa-lightitalic-nerd-font.ttc"
  font "sarasa-regular-nerd-font.ttc"
  font "sarasa-semibold-nerd-font.ttc"
  font "sarasa-semibolditalic-nerd-font.ttc"
end
EOF
)

file="${root}/Casks/font-sarasa-nerd-font-ttc.rb"
printf "${cask}" > $file
echo >> $file
