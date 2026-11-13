class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  license "MIT"
  version_scheme 1

  @arm64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.16/karls-gitflow-0.0.16-osx-arm64.zip"
  @x64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.16/karls-gitflow-0.0.16-osx-x64.zip"
  @arm64sha256 = "0f42a4a8f3f7fab458d81ee40c1c5982cc0ad49efb3ca2e3d908f8ca57d51e0a"
  @x64sha256 = "15fc2b2ec2ad4dfbc90bf1a512bcf4857ff3c34b6bb1400b195ff27bffe7d2ac"

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
    assert_equal "0.0.16", shell_output("#{bin}/git-flow --version").strip
  end
end
