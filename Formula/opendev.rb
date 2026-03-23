class OpendevCli < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e8ac92321de0e1e3b8b943ecae39a570ed16fe8b0f42b3ba0bbf5abb9eef055f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4599498b78f32aaeecf13bc9de5e1a55b63ac623574968e52eefb66902c0b732"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7f30126095d8000653864f09f716ee774072a199d2139b49625191e5c4b2fee2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2c6d25d30971d5bdf183984d286662471ea8cad7c2900229921a9004a0cf5b26"
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
