# homebrew-tap

Homebrew tap for [NotchPill](https://github.com/shawngeorgie06/NotchPill) — a
Dynamic Island-style notch overlay for macOS.

## Install

```sh
brew install --cask shawngeorgie06/tap/notchpill
```

That downloads the latest release, strips the Gatekeeper quarantine flag, and
installs to `/Applications`. Look for the notch icon in your menu bar.

## Update

```sh
brew upgrade --cask notchpill
```

## Uninstall

```sh
brew uninstall --cask notchpill        # remove the app
brew uninstall --zap --cask notchpill  # also remove preferences and ~/.notchpill
```

## Notes

NotchPill is ad-hoc signed (no paid Apple Developer account), so it is **not
notarized**. Homebrew installs it cleanly anyway — the cask's `postflight` step
removes the `com.apple.quarantine` attribute that would otherwise trigger the
"Apple could not verify…" warning. Requires macOS 14 (Sonoma) or newer on Apple
Silicon.
