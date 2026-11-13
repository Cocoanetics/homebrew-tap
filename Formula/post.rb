class Post < Formula
  desc "Local mail daemon, MCP server, and CLI — built in Swift"
  homepage "https://github.com/Cocoanetics/Post"
  url "https://github.com/Cocoanetics/Post/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "4512f00e44f872e1e4afecc570ff3ccaaaf6a290c1af894669027a95772d80fb"
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
      Post requires server credentials before use. Store them in the Keychain
      (you will be prompted for the password):

         post credential set --server <server-id> --host <host> --port 993 --username <user>
         postd start

      Without ~/.post.json, servers are discovered from the Keychain. If you
      have ~/.post.json, add the server id there first (e.g. "<server-id>": {})
      before running `post credential set`. See GitHub for advanced settings.
    EOS
  end

  test do
    assert_match "post", shell_output("#{bin}/post --help")
    assert_match "postd", shell_output("#{bin}/postd --help")
  end
end
