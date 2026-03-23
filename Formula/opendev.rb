class OpendevCli < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f2861237036546e87280f14d243bae1b25602f1e45fbc743c7083cf4f812c39a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "66c08d64d29052bcf71902ab084fcfe551dcfdf14c721a690d5eb1d74f50267f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "567e46720e5952a93325136ea549d8bfecd5422b7f94e0e36fd3154e81423921"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.0/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a813c494038465cc79b2fe9c459ad3cd3d784eef8fc73c3a6356ae577b0f84e"
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
