class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  license "MIT"
  version_scheme 1

  @arm64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.15/karls-gitflow-0.0.15-osx-arm64.zip"
  @x64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.15/karls-gitflow-0.0.15-osx-x64.zip"
  @arm64sha256 = "92f7c0ef3cc92967d19cc6a91d0c0bddecba58d8f86a8a12e2ff9b1ca8ffbb65"
  @x64sha256 = "a1f8a3e5376c775866d2ff2ebab97c28980efb5fc4f8ed5df97d77582184ac78"

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
  conflicts_with "git-flow-next", because: "both install the same binaries"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"git-flow"
  end

  test do
    assert_equal "0.0.15", shell_output("#{bin}/git-flow --version").strip
  end
end
