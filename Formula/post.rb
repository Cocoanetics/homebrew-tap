class Post < Formula
  desc "Local mail daemon, MCP server, and CLI — built in Swift"
  homepage "https://github.com/Cocoanetics/Post"
  url "https://github.com/Cocoanetics/Post/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "abe42b45deeaa7ec22b53a5e20534b0bdadbb864507e6234c997a4882e1f50ee"
  license "MIT"

  # Package.swift declares swift-tools-version 6.3, which first ships in
  # Xcode 26.4 (SwiftText 2.2+ requires it).
  depends_on xcode: ["26.4", :build]
  # SwiftMail 1.16 pins a swift-nio-imap revision that declares macOS 15.
  depends_on macos: :sequoia

  def install
    # Write the formula version so the SwiftPM build plugin can pick it up
    # (since the Homebrew tarball has no git history for `git describe`)
    File.write(".version", version)

    # SwiftPM plugins + Homebrew sandboxing can conflict on some systems.
    # Disable SwiftPM sandbox to ensure the manifest and build steps can run.
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/post"
    bin.install ".build/release/postd"
  end

  def caveats
    <<~EOS
      Post requires server credentials before use:

         post keychain add <server-id> --host <host> --port 993
         postd start

      No config file needed — servers are auto-discovered from the keychain.
      For advanced settings, create ~/.post.json (see GitHub for details).
    EOS
  end

  test do
    assert_match "post", shell_output("#{bin}/post --help")
    assert_match "postd", shell_output("#{bin}/postd --help")
  end
end
