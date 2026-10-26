class Swiftshot < Formula
  desc "Screenshots of SwiftUI and UIKit previews without booting a simulator"
  homepage "https://github.com/LukasAnda/swiftshot"
  url "https://github.com/LukasAnda/swiftshot/releases/download/v0.2.1/swiftshot-macos-arm64.tar.gz"
  version "0.2.1"
  sha256 "5d4dedbd78fbf92438b1e2e32c47572011a19fb152252dfaa4d8fb52cf429fd9"
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
