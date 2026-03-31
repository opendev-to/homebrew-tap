class Opendev < Formula
  desc "Binary entry point for the OpenDev CLI"
  homepage "https://github.com/opendev-to/opendev"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-aarch64-apple-darwin.tar.xz"
      sha256 "cf5d44b07ba76991d536c509932800a92a064921e3bab2aa2a95535bce9e45a7"

  resource "microsandbox" do
    on_arm do
      url "https://github.com/superradcompany/microsandbox/releases/download/v0.3.3/microsandbox-darwin-aarch64.tar.gz"
      sha256 "f5d10af7b7ee7bb9f3b81bb0daeca8276e05aa1660cd653935f338795c6d19ec"
    end
  end
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1eeb4bcc9d5e85d99497b1cdbea85026f6e189ad3228771fd43bc5d1d462b6a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "747e2532abc6dae619eb7f4e151ca5374c8a408446eeb536af65f35a66150631"
    end
    if Hardware::CPU.intel?
      url "https://github.com/opendev-to/opendev/releases/download/v0.1.6/opendev-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3b7dc8b35dfbda0344ddcc653677a2fd8b6eeab6ed863680c997a049a5b76b68"
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
