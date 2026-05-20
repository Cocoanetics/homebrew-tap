class Swifttext < Formula
  desc "Swiss-army knife for text extraction and document conversion — built in Swift"
  homepage "https://github.com/Cocoanetics/SwiftText"
  url "https://github.com/Cocoanetics/SwiftText/archive/refs/tags/1.1.9.tar.gz"
  sha256 "1d8a3c2ba5490f5befdc06f11ad609a095e76b6d27ea030db05eaefba7ce5d10"
  license "MIT"

  depends_on xcode: ["16.0", :build]
  depends_on :macos

  def install
    # Write the formula version so the SwiftPM build plugin can pick it up
    # (since the Homebrew tarball has no git history for `git describe`)
    File.write(".version", version)

    system "swift", "build", "-c", "release", "--disable-sandbox", "--enable-all-traits"
    bin.install ".build/release/swifttext"
  end

  test do
    assert_match "swifttext", shell_output("#{bin}/swifttext --help")
  end
end
