# The Homebrew formula (LukasAnda/homebrew-tap), written from this template by the release
# workflow: 0.7.0, https://github.com/LukasAnda/swiftshot/releases/download/v0.7.0 (the release download folder) and the two archives' checksums.
class Swiftshot < Formula
  desc "Screenshot tests and store screenshots from SwiftUI, UIKit and Compose previews"
  homepage "https://github.com/LukasAnda/swiftshot"
  version "0.7.0"
  license "AGPL-3.0-only"

  # Apple silicon Mac: iOS, Android, desktop and Compose Multiplatform.
  on_macos do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v0.7.0/swiftshot-macos-arm64.tar.gz"
    sha256 "edf46d167a6b6e2c4c8faab19b898b14c9e1ca6ce7d45fa3da03bbc5688afdf2"
    depends_on arch: :arm64
    depends_on xcode: "26.6"
  end

  # Linux: Android, desktop and the Android and desktop targets of Compose Multiplatform.
  on_linux do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v0.7.0/swiftshot-android.tar.gz"
    sha256 "a35f6eb817c360bf548ccfe715c02048b5de5576a825718052c9209f78590d1f"
    depends_on "openjdk@21"
  end

  def install
    # The simulator agents and renderer jars stay next to the launcher.
    libexec.install Dir["bin/*"]
    if OS.linux?
      (bin/"swiftshot").write_env_script libexec/"swiftshot", Language::Java.overridable_java_home_env("21")
    else
      bin.install_symlink libexec/"swiftshot"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swiftshot --version")
  end
end
