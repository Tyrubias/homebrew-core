class BazelDiff < Formula
  desc "Performs Bazel Target Diffing between two revisions in Git"
  homepage "https://github.com/Tinder/bazel-diff/"
  url "https://github.com/Tinder/bazel-diff/releases/download/8.1.1/bazel-diff_deploy.jar"
  sha256 "42334bd889a5941926d86adc903e4f8338d8873d70c457b91538fef7c9a63124"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "f471e82601a6d4e31824d753d76c1436ba3a9f98f563515531baedc8f0fc7fab"
  end

  depends_on "bazel" => :test
  depends_on "openjdk"

  def install
    libexec.install "bazel-diff_deploy.jar"
    bin.write_jar_script libexec/"bazel-diff_deploy.jar", "bazel-diff"
  end

  test do
    output = shell_output("#{bin}/bazel-diff generate-hashes --workspacePath=#{testpath} 2>&1", 1)
    assert_match "ERROR: The 'info' command is only supported from within a workspace", output
  end
end
