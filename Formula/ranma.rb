class Ranma < Formula
  desc "Programmable macOS menu bar overlay"
  homepage "https://github.com/typester/ranma"
  version "0.1.12"
  license "MIT"

  on_arm do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-arm64-#{version}.tar.gz"
    sha256 "325ce01d11786c320ca8633efb92345e9a4d80cfd10fcacf8e226c2d9cdc1024"
  end

  on_intel do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-x86_64-#{version}.tar.gz"
    sha256 "29a83848e6016830e14a29580dfd2a5d03ef218a01fad5a3a9d23b794775e56a"
  end

  def install
    bin.install "ranma"
    bin.install "ranma-server"
  end

  test do
    assert_match "ranma", shell_output("#{bin}/ranma --help")
  end
end
