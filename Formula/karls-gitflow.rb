class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  version "0.0.13"
  license "MIT"
  version_scheme 1

  bottle do
    root_url "https://github.com/karl-sjogren/homebrew-tap/releases/download/karls-gitflow-0.0.13"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8df1c6280e4beb9dc88179c0b60a478c6617db63f227d42a7cc2a099451d0088"
    sha256 cellar: :any_skip_relocation, sequoia:     "d461ebfb0c17c12c87f7462fc77549173d3788ac8d58b7ed446386b3f41d6e44"
  end

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

  # Don't have any linux binaries available yet, so limit to macOS
  depends_on :macos
  # .NET Core 10 is only supported on macOS 15 and later
  depends_on macos: :sequoia

  conflicts_with "git-flow", because: "both install the same binaries"
  conflicts_with "git-flow-next", because: "both install the same binaries"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"git-flow"
  end

  test do
    assert_equal "0.0.13", shell_output("#{bin}/git-flow --version").strip
  end
end
