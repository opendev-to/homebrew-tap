class Opendev < Formula
  resource "microsandbox" do
    on_macos do
      on_arm do
        url "https://github.com/superradcompany/microsandbox/releases/download/v0.3.3/microsandbox-darwin-aarch64.tar.gz"
        sha256 "f5d10af7b7ee7bb9f3b81bb0daeca8276e05aa1660cd653935f338795c6d19ec"
      end
    end
  end

  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.9/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6b50c2daf1801e912adda8350a6e7c77f62eb87cd5171729711d1fd1282e29b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.9/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c48de7c3191aed5fe7bea93c76657aabf053ac5bd18d34b7e7f69cd60b24ccb0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.9/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1ebe17046805c3fc8d52258bce9fa5590b797ddd0480bef32c92c01ee8c07061"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.9/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a64752cd4fa34265c2c777191ee7bec5f9e896d750ea95a3118b25dd332bf524"
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
    if OS.mac? && Hardware::CPU.arm?
      resource("microsandbox").stage do
        (libexec/"msb/bin").install Dir["bin/*"]
        (libexec/"msb/lib").install Dir["lib/*"]
      end
    end
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "opendev"
    if OS.mac? && Hardware::CPU.arm?
      resource("microsandbox").stage do
        (libexec/"msb/bin").install Dir["bin/*"]
        (libexec/"msb/lib").install Dir["lib/*"]
      end
    end
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "opendev"
    if OS.mac? && Hardware::CPU.arm?
      resource("microsandbox").stage do
        (libexec/"msb/bin").install Dir["bin/*"]
        (libexec/"msb/lib").install Dir["lib/*"]
      end
    end
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "opendev"
    if OS.mac? && Hardware::CPU.arm?
      resource("microsandbox").stage do
        (libexec/"msb/bin").install Dir["bin/*"]
        (libexec/"msb/lib").install Dir["lib/*"]
      end
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
