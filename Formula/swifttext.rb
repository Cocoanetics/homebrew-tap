class Swifttext < Formula
  desc "Swiss-army knife for text extraction and document conversion — built in Swift"
  homepage "https://github.com/Cocoanetics/SwiftText"
  url "https://github.com/Cocoanetics/SwiftText/archive/refs/tags/2.3.0.tar.gz"
  sha256 "514e68e3b57e1a598d73496b3dafc74c49c0bb075b0db82ed1243c2d417b2707"
  license "MIT"

  # Package.swift declares swift-tools-version 6.3, which first ships in
  # Xcode 26.4. (SwiftTextOCR also needs the macOS 26 SDK's Vision
  # document-recognition APIs, which 26.4 includes.)
  depends_on xcode: ["26.4", :build]
  depends_on :macos

  def install
    # Write the formula version so the SwiftPM build plugin can pick it up
    # (the Homebrew tarball has no git history for `git describe`).
    File.write(".version", version)

    system "swift", "build", "-c", "release", "--disable-sandbox", "--enable-all-traits"
    bin.install ".build/release/swifttext"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/swifttext --version")
  end
end
