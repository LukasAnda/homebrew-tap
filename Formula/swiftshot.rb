# The Homebrew formula (LukasAnda/homebrew-tap), written from this template by the release
# workflow: 1.0.0, https://github.com/LukasAnda/swiftshot/releases/download/v1.0.0 (the release download folder) and the two archives' checksums.
class Swiftshot < Formula
  desc "Screenshot tests and store screenshots from SwiftUI, UIKit and Compose previews"
  homepage "https://github.com/LukasAnda/swiftshot"
  version "1.0.0"
  license "AGPL-3.0-only"

  # Apple silicon Mac: iOS, Android, desktop and Compose Multiplatform.
  on_macos do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v1.0.0/swiftshot-macos-arm64.tar.gz"
    sha256 "c50345726fdfaef7fdf2510b6061b3391240e15896b9b02d7b2e55fb18a9471f"
    depends_on arch: :arm64
    depends_on xcode: "26.6"
  end

  # Linux: Android, desktop and the Android and desktop targets of Compose Multiplatform.
  on_linux do
    url "https://github.com/LukasAnda/swiftshot/releases/download/v1.0.0/swiftshot-android.tar.gz"
    sha256 "7c407a48c660c80fa2cc5479b360ca95327a10bb5ad5af8c1d7bc7236d3d5563"
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
