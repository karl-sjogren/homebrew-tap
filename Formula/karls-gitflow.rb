class KarlsGitflow < Formula
  name "karls-gitflow"
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  url "https://github.com/karl-sjogren/karls-gitflow/releases/download/#{version}/karls-gitflow-#{version}-osx-#{arch}.zip"
  version "0.0.14"
  license "MIT"

  bottle do
    on_arm do
      arch "arm64"
      sha256 "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101"
    end

    on_intel do
      arch "x64"
      sha256 "b115ed8ce3a2ac3a4c089b92fc462342f75fdfa8e1201186cf3f5d1f01af9c7d"
    end
  end

  depends_on macos: :sequoia

  conflicts_with cask: "git-flow"
  conflicts_with cask: "git-flow-next"
  # Don't have any linux binaries available yet, so limit to macOS
  # .NET Core 10 is only supported on macOS 15 and later

  postflight_steps do
    libexec.install Dir["*"]
    bin.install_symlink libexec/"git-flow"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/git-flow --version").strip
  end
end
