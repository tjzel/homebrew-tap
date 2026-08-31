class Szpont < Formula
  desc "szpont machen — AI session manager TUI for Claude Code, Codex and Kimi Code"
  homepage "https://github.com/tjzel/szpont-machen"
  version "1.0.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.10/szpont-aarch64-apple-darwin.tar.xz"
      sha256 "ec2e817a8549b0abb751eb9bf8577e2490e6a6c0c6b0500cfe25eaf8e21e8916"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.10/szpont-x86_64-apple-darwin.tar.xz"
      sha256 "0b0bb9c2063439e46ce41c0ea46e15a0ae800e2653b331bc0906bb73ad8b2038"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.10/szpont-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "58a6e8bef2d9db69bab80b1b636d200e4b33280624a023e4ad9462a1d137043a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tjzel/szpont-machen/releases/download/v1.0.10/szpont-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aa887d4f65cf491be613b041c6d81aa23fa58e78f441ad5669c68f7ec5823d49"
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
