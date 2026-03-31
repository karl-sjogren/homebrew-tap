class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  version "0.0.13"
  license "MIT"
  version_scheme 1

  @arm64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.13/karls-gitflow-0.0.13-osx-arm64.zip"
  @x64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.13/karls-gitflow-0.0.13-osx-x64.zip"
  @arm64sha256 = "c20e79d97701f82d36d88c905fd2ad688b8b082a920a189c8c1f551ee4459030"
  @x64sha256 = "b1f812f0e91d658f1636e3a958c40610aa6be5a58799ddcae0a2a1538c6111d2"

  if Hardware::CPU.intel?
    url @x64url
    sha256 @x64sha256
  else
    url @arm64url
    sha256 @arm64sha256
  end

  # .NET Core 10 is only supported on macOS 15 and later
  depends_on macos: :sequoia

  conflicts_with "git-flow", because: "both install the same binaries"
  conflicts_with "git-flow-avh", because: "both install the same binaries"
  conflicts_with "git-flow-next", because: "both install the same binaries"

  test do
    assert_equal "0.0.13", shell_output("#{bin}/git-flow version").strip
  end
end
