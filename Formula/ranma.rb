class Ranma < Formula
  desc "Programmable macOS menu bar overlay"
  homepage "https://github.com/typester/ranma"
  version "0.1.10"
  license "MIT"

  on_arm do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-arm64-#{version}.tar.gz"
    sha256 "63c8205fc29a7d164aaacf83bb3f6a40246d8e6518af8aeb956d66640300c31d"
  end

  on_intel do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-x86_64-#{version}.tar.gz"
    sha256 "a33513a73b7c1835bc0afba2d09ee7ffa2ad91570bf3b15d38a98854006175b4"
  end

  def install
    bin.install "ranma"
    bin.install "ranma-server"
  end

  test do
    assert_match "ranma", shell_output("#{bin}/ranma --help")
  end
end
