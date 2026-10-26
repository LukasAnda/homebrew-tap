class Swiftshot < Formula
  desc "Screenshots of SwiftUI and UIKit previews without booting a simulator"
  homepage "https://github.com/LukasAnda/swiftshot"
  url "https://github.com/LukasAnda/swiftshot/releases/download/v0.3.0/swiftshot-macos-arm64.tar.gz"
  sha256 "932f70e670e941f5153e2bc3d31fe62c3135b2c585bb453ad18fc573093eeaf1"
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
