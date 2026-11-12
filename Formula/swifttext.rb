class Swifttext < Formula
  desc "Swiss-army knife for text extraction and document conversion — built in Swift"
  homepage "https://github.com/Cocoanetics/SwiftText"
  url "https://github.com/Cocoanetics/SwiftText/archive/refs/tags/2.9.0.tar.gz"
  sha256 "1112fa856969656ed6508c6486c296b057a8619ec2869a6b89446eabc17f62c7"
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
