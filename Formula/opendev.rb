class OpendevCli < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "44cbdd4153cf79bc54e0dca6f95528a510f6d619b187dfffce5f36e03b2024fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "705a7cb5ae234da22647873f2c8d94d7a5c770fd5c8b887f026b987992da9244"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "985500eff5e97095d7d251de48b7e8f3f6d0f2b3c862b50d95342606bac31bb6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0504cbeb8dacc9c8666a32b229ebf8da0508977a81b016e1e1201ea717082a8e"
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
