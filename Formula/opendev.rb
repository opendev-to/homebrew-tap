class Opendev < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "57fb3eef2d2e2526b488935e059ccb0fbe6a2a8c2265e7ffa6b66a86bc3cfa1d"

  resource "microsandbox" do
    on_arm do
      url "https://github.com/superradcompany/microsandbox/releases/download/v0.3.3/microsandbox-darwin-aarch64.tar.gz"
      sha256 "f5d10af7b7ee7bb9f3b81bb0daeca8276e05aa1660cd653935f338795c6d19ec"
    end
  end
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c248f2cd5c7c73ebebf68589875e37df5f4f0e24755e04957988564e5140a78c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c7542260b640a6bd34ca2ca453806db4adee13473b2ebdc2358060e87294af8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e5a2360cd767ece2adf131a324c658cb4230a24d81809c6f1a8c117c772f4a62"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "opendev"
    resource("microsandbox").stage do
      (libexec/"msb/bin").install Dir["bin/*"]
      (libexec/"msb/lib").install Dir["lib/*"]
    end
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "opendev"
    resource("microsandbox").stage do
      (libexec/"msb/bin").install Dir["bin/*"]
      (libexec/"msb/lib").install Dir["lib/*"]
    end
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "opendev"
    resource("microsandbox").stage do
      (libexec/"msb/bin").install Dir["bin/*"]
      (libexec/"msb/lib").install Dir["lib/*"]
    end
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "opendev"
    resource("microsandbox").stage do
      (libexec/"msb/bin").install Dir["bin/*"]
      (libexec/"msb/lib").install Dir["lib/*"]
    end
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
