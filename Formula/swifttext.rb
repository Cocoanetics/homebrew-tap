class Swifttext < Formula
  desc "Swiss-army knife for text extraction and document conversion — built in Swift"
  homepage "https://github.com/Cocoanetics/SwiftText"
  url "https://github.com/Cocoanetics/SwiftText/archive/refs/tags/1.1.4.tar.gz"
  sha256 "42f94b4eb95eb4216729fbce8c9bc114a10d02af6a3523df5d0c66d1b2039d36"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox", "--enable-all-traits"
    bin.install ".build/release/swifttext"
  end

  test do
    assert_match "swifttext", shell_output("#{bin}/swifttext --help")
  end
end
