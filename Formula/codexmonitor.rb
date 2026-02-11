class Codexmonitor < Formula
  desc "List, inspect, and watch local OpenAI Codex sessions"
  homepage "https://github.com/Cocoanetics/CodexMonitor"
  url "https://github.com/Cocoanetics/CodexMonitor/archive/refs/tags/0.1.1.tar.gz"
  sha256 "1e5ead48e8a6c7eebbd22525c6769860396d5d2b1d8912794504a06dd4dc8aa7"
  license "MIT"

  depends_on xcode: ["16.0", :build]

  def install
    # SwiftPM plugins + Homebrew sandboxing can conflict on some systems.
    # Disable SwiftPM sandbox to ensure the manifest and build steps can run.
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/CodexMonitor-CLI" => "codexmonitor"
  end

  test do
    system bin/"codexmonitor", "--help"
  end
end
