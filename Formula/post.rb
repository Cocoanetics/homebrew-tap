class Post < Formula
  desc "Local mail daemon, MCP server, and CLI — built in Swift"
  homepage "https://github.com/Cocoanetics/Post"
  url "https://github.com/Cocoanetics/Post/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "66f56ea64b6dd819ec974d188b8f1b6895d410dad2b6eb69cfb84ef75b5eab46"
  license "MIT"

  # Package.swift declares swift-tools-version 6.2, which ships in Xcode 26.0.
  depends_on xcode: ["26.0", :build]

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
