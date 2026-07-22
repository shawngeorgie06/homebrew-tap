cask "notchpill" do
  version "1.2.0"
  sha256 "112d1d94fde211594e533e164ef308e24520eb6aace1a02cf8ac11199fc66fd3"

  url "https://github.com/shawngeorgie06/NotchPill/releases/download/v#{version}/NotchPill-#{version}-macOS-arm64.zip"
  name "NotchPill"
  desc "Dynamic Island-style notch overlay for macOS"
  homepage "https://github.com/shawngeorgie06/NotchPill"

  # NotchPill ships ad-hoc/self-signed (no paid Apple Developer account), so it
  # is not notarized. Homebrew still installs it cleanly because the postflight
  # below strips the quarantine flag that would otherwise trip Gatekeeper.
  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "NotchPill-#{version}-macOS-arm64/NotchPill.app"

  postflight do
    # Remove the quarantine attribute so the ad-hoc-signed app launches without
    # the "Apple could not verify…" wall. Equivalent to `xattr -dr` by hand.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/NotchPill.app"],
                   sudo: false
  end

  uninstall quit: "com.local.notchpill"

  zap trash: [
    "~/Library/Preferences/com.local.notchpill.plist",
    "~/Library/Caches/com.local.notchpill",
    "~/.notchpill",
  ]

  caveats <<~EOS
    NotchPill runs from the menu bar (top-right notch icon) — no Dock icon.

    For hover keyboard shortcuts (Space / arrows over the notch), enable it in:
      System Settings → Privacy & Security → Accessibility → NotchPill

    It is ad-hoc signed (not notarized). If macOS still blocks it, run:
      xattr -dr com.apple.quarantine /Applications/NotchPill.app
  EOS
end
