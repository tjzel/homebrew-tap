class Szpont < Formula
  desc "szpont machen — AI session manager TUI for Claude Code, Codex and Kimi Code"
  homepage "https://github.com/tjzel/szpont-machen"
  version "1.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.6/szpont-aarch64-apple-darwin.tar.xz"
      sha256 "8a753860cea64abe65ac86bada09e5fe9051585e18fd2aaa17e8de4285abc977"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.6/szpont-x86_64-apple-darwin.tar.xz"
      sha256 "7ac5ac0d43359b72e9b3a243bf426f410c254d8c3fa67ff636da4b784e83d7ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.6/szpont-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5bc1ad08f33f35466c565b443165e84700e6248d60cfcaf4a4dabfed2749dc5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.6/szpont-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5aa735fcfca07037375846ff351b3e1769614bba1d099e0904f539b599d01a61"
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
