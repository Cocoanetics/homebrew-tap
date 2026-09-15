class Swifttext < Formula
  desc "Swiss-army knife for text extraction and document conversion — built in Swift"
  homepage "https://github.com/Cocoanetics/SwiftText"
  url "https://github.com/Cocoanetics/SwiftText/archive/refs/tags/2.2.0.tar.gz"
  sha256 "943209f932544d40d1ccd17dd108a09eab454571a1aa791e691787e3de7c8c88"
  license "MIT"

  # SwiftTextOCR builds against the macOS 26 Vision document-recognition APIs
  # (RecognizeDocumentsRequest), so the macOS 26 SDK (Xcode 26 or newer) is required.
  depends_on xcode: ["26.0", :build]
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
