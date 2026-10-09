class KarlsGitflow < Formula
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  sha256 "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101"
  license "MIT"

  @version = "0.0.14"

  depends_on macos: :sequoia

  on_macos do
    on_arm do
      sha256 "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101"
      url "https://github.com/karl-sjogren/karls-gitflow/releases/download/#{@version}/karls-gitflow-#{@version}-osx-arm64.zip"
    end
    on_intel do
      sha256 "b115ed8ce3a2ac3a4c089b92fc462342f75fdfa8e1201186cf3f5d1f01af9c7d"
      url "https://github.com/karl-sjogren/karls-gitflow/releases/download/#{@version}/karls-gitflow-#{version}-osx-x64.zip"
    end
  end

  conflicts_with "git-flow", because: "both install the same binaries"
  conflicts_with "git-flow-next", because: "both install the same binaries"
  # Don't have any linux binaries available yet, so limit to macOS
  # .NET Core 10 is only supported on macOS 15 and later

  post_install_steps do
    # bin.install_symlink libexec/"git-flow"
    # symlink "git-flow", :libexec/"git-flow"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/git-flow --version").strip
  end
end
