# The Homebrew formula (LukasAnda/homebrew-tap), written from this template by the release
# workflow: 0.8.0, https://github.com/LukasAnda/swiftshot/releases/download/v0.8.0 (the release download folder) and the two archives' checksums.
class Swiftshot < Formula
  desc "Screenshot tests and store screenshots from SwiftUI, UIKit and Compose previews"
  homepage "https://github.com/LukasAnda/swiftshot"
  version "0.8.0"
  license "AGPL-3.0-only"

  # Apple silicon Mac: iOS, Android, desktop and Compose Multiplatform.
  on_macos do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v0.8.0/swiftshot-macos-arm64.tar.gz"
    sha256 "05ba2e35758cdf71855ef6568d26c0a196f2fa714f7f48d2c339ceb980c24156"
    depends_on arch: :arm64
    depends_on xcode: "26.6"
  end

  # Linux: Android, desktop and the Android and desktop targets of Compose Multiplatform.
  on_linux do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v0.8.0/swiftshot-android.tar.gz"
    sha256 "d6e2c7fc4bbd42bc04e114c39f8fa3bb664506df85fc83f66a406b565c568535"
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
