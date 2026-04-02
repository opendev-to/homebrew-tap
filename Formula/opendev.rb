class Opendev < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.8/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "679e1b89f9a37e27927af519d0d6b01d0cec9227aeb1ca379a0722f55915b942"

  resource "microsandbox" do
    on_arm do
      url "https://github.com/superradcompany/microsandbox/releases/download/v0.3.3/microsandbox-darwin-aarch64.tar.gz"
      sha256 "f5d10af7b7ee7bb9f3b81bb0daeca8276e05aa1660cd653935f338795c6d19ec"
    end
  end
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.8/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a47eb1d46bec72a29e5b9df46525b6f77a1a6d12367b6a8fcf23d9ac646cfddb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.8/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17508e599a1ecb7b76664cf218c8ec5ee80a2d89c4ae81059fc9bc91daccde7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.8/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8134ec1626c7631677a90d2cfd20f558e55733541e4383d16b1da1d2d6bc37f"
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
