class Post < Formula
  desc "Local mail daemon, MCP server, and CLI — built in Swift"
  homepage "https://github.com/Cocoanetics/Post"
  url "https://github.com/Cocoanetics/Post/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "5c354dfaec4431a4a60717d023ad752585cd3171dbb8cfc1fcc1640935aefd60"
  license "MIT"

  depends_on xcode: ["16.0", :build]

  def install
    # SwiftPM plugins + Homebrew sandboxing can conflict on some systems.
    # Disable SwiftPM sandbox to ensure the manifest and build steps can run.
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/post"
    bin.install ".build/release/postd"
  end

  def caveats
    <<~EOS
      Post requires configuration before use:

      1. Add server credentials to keychain:
         post keychain add <server-id> --host <host> --port 993

      2. Create config file:
         echo '{ "servers": { "<server-id>": {} } }' > ~/.post.json

      3. Start the daemon:
         postd start

      See https://github.com/Cocoanetics/Post for full documentation.
    EOS
  end

  test do
    assert_match "post", shell_output("#{bin}/post --help")
    assert_match "postd", shell_output("#{bin}/postd --help")
  end
end
