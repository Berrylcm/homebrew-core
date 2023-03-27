class Httm < Formula
  desc "Interactive, file-level Time Machine-like tool for ZFS/btrfs"
  homepage "https://github.com/kimono-koans/httm"
  url "https://github.com/kimono-koans/httm/archive/refs/tags/0.24.2.tar.gz"
  sha256 "a22dc05280f59ff7ca71d624cfc0ffbda7dcc8793df260cd747b5f19d89f43d4"
  license "MPL-2.0"
  head "https://github.com/kimono-koans/httm.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "31e1ecfd1d9bd12738e314ef5e1efb3bbaca2b860e30249883c3ab03ee337305"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "73c98d80baac9932f33e5455c26d30aa1860a1430632bad8eedfab5aa2774b53"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "670d25a31d90f26633abbb82488ca3c70d7378ad5e5551f0950ce25a7fee07ed"
    sha256 cellar: :any_skip_relocation, ventura:        "4b1e4982223c0ddc067ba4d6728d3e9335fb6fc883c1f3732148af664d31d420"
    sha256 cellar: :any_skip_relocation, monterey:       "fe29725068e9242b18e24642c547a316158218822170933b7feadda750802bb1"
    sha256 cellar: :any_skip_relocation, big_sur:        "438ad8b1a45ec5dde5961b7da8f0eb072bf156a2b112fab25e80bb5b7a29c2bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "58c4b933051ab906f16bb7699df9292e196ef8b6537030ec282aea3826a5b255"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    man1.install "httm.1"
  end

  test do
    touch testpath/"foo"
    assert_equal "Error: httm could not find any valid datasets on the system.",
      shell_output("#{bin}/httm #{testpath}/foo 2>&1", 1).strip
    assert_equal "httm #{version}", shell_output("#{bin}/httm --version").strip
  end
end
