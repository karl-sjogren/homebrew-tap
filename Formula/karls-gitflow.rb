formula "karls-gitflow" do
  version "0.0.14"

  bottle do
    sha256 arm:   "00b3934c8ae570b563c1ff30647112a92818bdaa6cc3c5a316b7c100bfc4e101",
           intel: "b115ed8ce3a2ac3a4c089b92fc462342f75fdfa8e1201186cf3f5d1f01af9c7d"
  end

  url "https://github.com/karl-sjogren/karls-gitflow/releases/download/#{version}/karls-gitflow-#{version}-osx-#{arch}.zip"
  name "karls-gitflow"
  desc "Opinionated Git Flow implementation written in .NET"
  homepage "https://github.com/karl-sjogren/karls-gitflow"

  conflicts_with cask: "git-flow"
  conflicts_with cask: "git-flow-next"
  # Don't have any linux binaries available yet, so limit to macOS
  # .NET Core 10 is only supported on macOS 15 and later
  depends_on macos: :sequoia

  postflight_steps do
    libexec.install Dir["*"]
    bin.install_symlink libexec/"git-flow"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/git-flow --version").strip
  end
end
