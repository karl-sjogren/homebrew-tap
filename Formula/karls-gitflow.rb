class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  version "0.0.14"
  license "MIT"
  version_scheme 1

  on_macos do
    bottle do
      root_url "https://github.com/karl-sjogren/homebrew-tap/releases/download/karls-gitflow-0.0.14"
      sha256 cellar: :any_skip_relocation, arm64_tahoe: "8df1c6280e4beb9dc88179c0b60a478c6617db63f227d42a7cc2a099451d0088"
      sha256 cellar: :any_skip_relocation, sequoia:     "d461ebfb0c17c12c87f7462fc77549173d3788ac8d58b7ed446386b3f41d6e44"
    end
  
    @arm64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.14/karls-gitflow-0.0.14-osx-arm64.zip"
    @x64url = "https://github.com/karl-sjogren/karls-gitflow/releases/download/0.0.14/karls-gitflow-0.0.14-osx-x64.zip"
    @arm64sha256 = "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101"
    @x64sha256 = "b115ed8ce3a2ac3a4c089b92fc462342f75fdfa8e1201186cf3f5d1f01af9c7d"
  
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
      assert_equal "0.0.14", shell_output("#{bin}/git-flow --version").strip
    end
  end
end
