class Codexmonitor < Formula
  desc "List, inspect, and watch local OpenAI Codex sessions"
  homepage "https://github.com/Cocoanetics/CodexMonitor"
  url "https://github.com/Cocoanetics/CodexMonitor/archive/refs/tags/0.1.0.tar.gz"
  sha256 "25cf4eb16a3146e35b1bfde6fc5df534884161f4f768c995c48b84eac59951bf"
  license "MIT"

  depends_on xcode: ["16.0", :build]

  def install
    # SwiftPM plugins + Homebrew sandboxing can conflict on some systems.
    # Disable SwiftPM sandbox to ensure the manifest and build steps can run.
    ENV["SWIFTPM_DISABLE_SANDBOX"] = "1"

    system "swift", "build", "-c", "release"
    bin.install ".build/release/CodexMonitor-CLI" => "codexmonitor"
  end

  test do
    system "#{bin}/codexmonitor", "--help"
  end
end
