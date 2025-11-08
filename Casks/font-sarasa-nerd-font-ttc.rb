cask "font-sarasa-nerd-font-ttc" do
  version "1.0.34-0"
  sha256 "062e5054356f8dc658cf25d2c4915a6586bd22a5bb34b92f3a158982204243a0"

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
