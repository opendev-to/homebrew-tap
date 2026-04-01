class Opendev < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.7/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7dfe8fc0855be7e5a8df870c4463349115e54585c460041f7a9d5feaddc64969"

  resource "microsandbox" do
    on_arm do
      url "https://github.com/superradcompany/microsandbox/releases/download/v0.3.3/microsandbox-darwin-aarch64.tar.gz"
      sha256 "f5d10af7b7ee7bb9f3b81bb0daeca8276e05aa1660cd653935f338795c6d19ec"
    end
  end
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.7/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f52ae5c48c83663520633a2303921b0785f6d69c2c91aa04a9b2936e1188a34c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.7/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "75b5d83a07687b8f634ec379183d55a04d7f33357440aace2df979cdca257b86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.7/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "232e9d9b2775bb4e9977ac8f65a50bdcc1dcef12fe36adc2a97dc8ac61a52583"
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
