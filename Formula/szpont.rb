class Szpont < Formula
  desc "szpont machen — AI session manager TUI for Claude Code, Codex and Kimi Code"
  homepage "https://github.com/tjzel/szpont-machen"
  version "1.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.9/szpont-aarch64-apple-darwin.tar.xz"
      sha256 "f4f9dccbdfd26c03dd534ad814ed9f47c4ecd8aaaeed09558b780dbdf874eeb3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.9/szpont-x86_64-apple-darwin.tar.xz"
      sha256 "0d907abff10e22d6ac5c1073226a07e1b1309ef1943eb2829cb97f7e92e3b963"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.9/szpont-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f175e4f9c357f25fc08503551663f95bc07ab0e836b8c465b59f216c2ed35898"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.9/szpont-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89bb060c9f49dcdc6807fbac79e95922065b8afb7ab5a5f9b6d7193ea713fe1b"
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
