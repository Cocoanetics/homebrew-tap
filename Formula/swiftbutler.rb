class Swiftbutler < Formula
  desc "Swift source analysis, syntax checking, reindentation, and file distribution"
  homepage "https://github.com/Cocoanetics/SwiftButler"
  url "https://github.com/Cocoanetics/SwiftButler/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bf160aa128bfee50df28b6c2e3162cd737f0090f9187c77f3dac0934e526cdee"
  license "MIT"

  on_macos do
    depends_on xcode: ["16.0", :build]
  end

  on_linux do
    depends_on "swift" => :build
  end

  def install
    # Write the formula version so the SwiftPM build plugin can pick it up
    # (since the Homebrew tarball has no git history for `git describe`)
    File.write(".version", version)

    # SwiftPM plugins + Homebrew sandboxing can conflict on some systems.
    # Disable SwiftPM sandbox to ensure the manifest and build steps can run.
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/butler"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/butler --version")
  end
end
