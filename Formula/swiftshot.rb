class Swiftshot < Formula
  desc "Screenshots of SwiftUI and UIKit previews without booting a simulator"
  homepage "https://github.com/LukasAnda/swiftshot"
  url "https://github.com/LukasAnda/swiftshot/releases/download/v0.4.0/swiftshot-macos-arm64.tar.gz"
  sha256 "43d477dc3b15b8930dfeaef39115e28122c73e7e525ec76d5fa21f60bfa2c0c1"
  license "AGPL-3.0-only"

  depends_on arch: :arm64
  depends_on :macos
  depends_on xcode: "26.6"

  def install
    # The simulator agents must stay next to the binary.
    libexec.install Dir["bin/*"]
    bin.install_symlink libexec/"swiftshot"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swiftshot --version")
  end
end
