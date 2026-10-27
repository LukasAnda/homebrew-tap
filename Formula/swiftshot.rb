class Swiftshot < Formula
  desc "Screenshots of SwiftUI and UIKit previews without booting a simulator"
  homepage "https://github.com/LukasAnda/swiftshot"
  url "https://github.com/LukasAnda/swiftshot/releases/download/v0.5.0/swiftshot-macos-arm64.tar.gz"
  sha256 "654e8686cc1aa3aeaf18343f95a520c241e83ae3f036afb4f7145b73f6a74674"
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
