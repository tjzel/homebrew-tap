class Szpont < Formula
  desc "szpont machen — AI session manager TUI for Claude Code, Codex and Kimi Code"
  homepage "https://github.com/tjzel/szpont-machen"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.1/szpont-aarch64-apple-darwin.tar.xz"
      sha256 "f84a813ce537fc975918f4925e997e3c8a418fa4b004f3f70ac016e25e8cac3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.1/szpont-x86_64-apple-darwin.tar.xz"
      sha256 "6ecfba5618a2307878e1dc566bdf0395e137fb66bddd3762937e023408622636"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.1/szpont-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58f5d4666cf86450777d908f9441b4d9765d595bb7d3ad09b57a31c7c7463b96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.1/szpont-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa85018aa525a0af0fab68a7ee3c89df6685e23e818fa9e85604e4e0831ef8b9"
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
