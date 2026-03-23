class OpendevCli < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "854efd3dfdf84881805b10b3a68665344a592800d157e2b3ba7946bfed556455"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c41d29338200b3e9081fef27f2922f191b8fccf230c110fae862de4515d54d81"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f90d733eb063e78a68da3b6e5f8989b37b923a2a1181a410dc83b8fb07899d0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad787ebb297f0e2d05f92c063dbc45b3e329854511a12b7d4f5317c88839ea91"
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
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "opendev"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "opendev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "opendev"
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
