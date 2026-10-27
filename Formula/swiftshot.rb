# The Homebrew formula (LukasAnda/homebrew-tap), written from this template by the release
# workflow: 0.6.0, https://github.com/LukasAnda/swiftshot/releases/download/v0.6.0 (the release download folder) and the two archives' checksums.
class Swiftshot < Formula
  desc "Screenshot tests and store screenshots from SwiftUI, UIKit and Compose previews"
  homepage "https://github.com/LukasAnda/swiftshot"
  version "0.6.0"
  license "AGPL-3.0-only"

  # Apple silicon Mac: iOS, Android, desktop and Compose Multiplatform.
  on_macos do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v0.6.0/swiftshot-macos-arm64.tar.gz"
    sha256 "2221f3874a1d9a12d937da874825787f183d311604cb5a1600a840554f7c27bd"
    depends_on arch: :arm64
    depends_on xcode: "26.6"
  end

  # Linux: Android, desktop and the Android and desktop targets of Compose Multiplatform.
  on_linux do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v0.6.0/swiftshot-android.tar.gz"
    sha256 "e3a0b78f9da99fa64b581427ed287d95d090622ee274512e804ec2906946f031"
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
