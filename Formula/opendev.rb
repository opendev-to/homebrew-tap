class Opendev < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.4/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b0df744b980546e60d6493823b1537b771636552206e859cc3852b061409ad5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.4/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "616379135091c87cbe0157032df5b1f6770a55dbaa9884d62cc43caa70c9817f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.4/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4fdafadeef932e61362a1681b16618b08c7ed690cca13115b425c68529165afb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.4/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0ac42a7c3c10cae9629e7d168d10c3dddc12f93916c3b767ecdffd131bf82d0"
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
