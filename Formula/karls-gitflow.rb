class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  version "0.0.14"
  license "MIT"
  version_scheme 1

  @arm64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.14/karls-gitflow-0.0.14-osx-arm64.zip"
  @x64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.14/karls-gitflow-0.0.14-osx-x64.zip"
  @arm64sha256 = "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101"
  @x64sha256 = "27a1a8999161dbe4ca0d6c62f811266b169f77dd1f16bc87a8880aacb8ca6254"

  if Hardware::CPU.intel?
    url @x64url
    sha256 @x64sha256
  else
    url @arm64url
    sha256 @arm64sha256
  end

  # .NET Core 10 is only supported on macOS 15 and later
  depends_on macos: :sequoia

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"git-flow"
  end

  test do
    assert_equal "0.0.14", shell_output("#{bin}/git-flow --version").strip
  end
end
