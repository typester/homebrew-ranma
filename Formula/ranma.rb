class Ranma < Formula
  desc "Programmable macOS menu bar overlay"
  homepage "https://github.com/typester/ranma"
  version "0.1.3"
  license "MIT"

  on_arm do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-arm64-#{version}.tar.gz"
    sha256 "0e9c7814f474b71b420faeb94e3cf2d35cdc06f2737888d8797998501cf47782"
  end

  on_intel do
    url "https://github.com/typester/ranma/releases/download/v#{version}/ranma-x86_64-#{version}.tar.gz"
    sha256 "a168ff041bd1046daf534edac267b61c5943e90ac4f0289bdadbf19a1adc3e8d"
  end

  def install
    bin.install "ranma"
    bin.install "ranma-server"
  end

  test do
    assert_match "ranma", shell_output("#{bin}/ranma --help")
  end
end
