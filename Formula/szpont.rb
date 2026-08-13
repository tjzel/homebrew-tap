class Szpont < Formula
  desc "szpont machen — AI session manager TUI for Claude Code, Codex and Kimi Code"
  homepage "https://github.com/tjzel/szpont-machen"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.4/szpont-aarch64-apple-darwin.tar.xz"
      sha256 "2c55779143ba436cc03e5c4db5a80971ae20e69c67a399dd3f99be3186ed01b7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.4/szpont-x86_64-apple-darwin.tar.xz"
      sha256 "69f463dcee16e77c6a7fabdc8dc13aededfc239172fae47b07f86e797d399df2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.4/szpont-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cb8f6a69091549dbf12241186f5fe5a24044fffcc12bf6f218058db64c5cd335"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.4/szpont-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d664a931b5d572e7755fe5849fab0ab312779f211e9a5a5e84584894c63a9b04"
    end
  end
  license "Unlicense"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "szpont"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "szpont"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "szpont"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "szpont"
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
