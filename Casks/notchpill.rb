cask "notchpill" do
  version "1.57.0"
  sha256 "1386e4ef81277c9ea13c753e70d8b3206925d420c80379f215b91ff49edf017d"

  url "https://github.com/shawngeorgie06/NotchPill/releases/download/v#{version}/NotchPill-#{version}-macOS-arm64.zip"
  name "NotchPill"
  desc "Dynamic Island-style notch overlay for macOS"
  homepage "https://github.com/shawngeorgie06/NotchPill"

  # NotchPill is self-signed (no paid Apple Developer account), so it is not
  # notarized. Homebrew still installs it cleanly because the postflight below
  # strips the quarantine flag that would otherwise trip Gatekeeper.
  #
  # A bare symbol already means ">= that version"; the string form is deprecated
  # and made every install print a warning telling users to file a bug here.
  depends_on macos: :sonoma
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

    It is self-signed (not notarized). If macOS still blocks it, run:
      xattr -dr com.apple.quarantine /Applications/NotchPill.app
  EOS
end
