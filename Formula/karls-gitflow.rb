cask "karls-gitflow" do
  version "0.0.14"

  if Hardware::CPU.arm?
    arch = "arm64"
    sha256 "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101"
  else
    arch = "x64"
    sha256 "b115ed8ce3a2ac3a4c089b92fc462342f75fdfa8e1201186cf3f5d1f01af9c7d"
  end
  
  url "https://github.com/karl-sjogren/karls-gitflow/releases/download/#{version}/karls-gitflow-#{version}-osx-#{arch}.zip"

  name "karls-gitflow"
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"
  license "MIT"

  # Don't have any linux binaries available yet, so limit to macOS
  # .NET Core 10 is only supported on macOS 15 and later
  depends_on macos: :sequoia

  conflicts_with "git-flow", because: "both install the same binaries"
  conflicts_with "git-flow-next", because: "both install the same binaries"

  post_install_steps do
    libexec.install Dir["*"]
    bin.install_symlink libexec/"git-flow"
  end

  test do
    assert_equal "#{version}", shell_output("#{bin}/git-flow --version").strip
  end
end
