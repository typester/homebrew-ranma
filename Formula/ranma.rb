class Ranma < Formula
  desc "Programmable macOS menu bar overlay"
  homepage "https://github.com/typester/ranma"
  version "0.1.4"
  license "MIT"

  on_arm do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-arm64-#{version}.tar.gz"
    sha256 "5e99f535eb5637f978c329e69b5422b5caab84d9693dd469c8dae1024d456c6c"
  end

  on_intel do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-x86_64-#{version}.tar.gz"
    sha256 "3968279f00a16d560ad23029f162236d87acc2edd578c8fd92dc80c858cef5ff"
  end

  def install
    bin.install "ranma"
    bin.install "ranma-server"
  end

  test do
    assert_match "ranma", shell_output("#{bin}/ranma --help")
  end
end
