class Ranma < Formula
  desc "Programmable macOS menu bar overlay"
  homepage "https://github.com/typester/ranma"
  version "0.1.7"
  license "MIT"

  on_arm do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-arm64-#{version}.tar.gz"
    sha256 "dff4ab23ecfa94492c33a2629d3a0e98dc65a02e97cf670b9faef3bc4979d2fc"
  end

  on_intel do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-x86_64-#{version}.tar.gz"
    sha256 "e25af6bd2ff8b3fdcaf9fd7f334532f2bc2c9ee51b339a24fed1d73b98b12d98"
  end

  def install
    bin.install "ranma"
    bin.install "ranma-server"
  end

  test do
    assert_match "ranma", shell_output("#{bin}/ranma --help")
  end
end
