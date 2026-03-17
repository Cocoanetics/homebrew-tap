class Swifttext < Formula
  desc "Swiss-army knife for text extraction and document conversion — built in Swift"
  homepage "https://github.com/Cocoanetics/SwiftText"
  url "https://github.com/Cocoanetics/SwiftText/archive/refs/tags/1.1.5.tar.gz"
  sha256 "6c07918ce3a2150eafcc6f5f3881793fe6ce9db16fafadfd6760490697a6bcea"
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
