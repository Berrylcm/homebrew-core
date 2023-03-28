class OhMyPosh < Formula
  desc "Prompt theme engine for any shell"
  homepage "https://ohmyposh.dev"
  url "https://github.com/JanDeDobbeleer/oh-my-posh/archive/v14.19.5.tar.gz"
  sha256 "db343e18a97a0b41800916352c688b5b36345df30fcbcd0b6b3c1d986d393091"
  license "MIT"
  head "https://github.com/JanDeDobbeleer/oh-my-posh.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "20402d5b50090f0656d80fbb04a8a16d6fbc09753d791c00b9a528464c583388"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a99b8df0518c4efbe85b98d8b8aca85a80949d8a58c89d9b5571088975360ea7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b058709b36098027c8b3f6a991773c3593393543063ac9ae3d5891642a2bbad9"
    sha256 cellar: :any_skip_relocation, ventura:        "3e5a99a4da7bc7732facee515d9f14e1418e2195943153327c0db4d0b874dcf9"
    sha256 cellar: :any_skip_relocation, monterey:       "60ed200012f9ddf3c0469d6544d5bd856b23f263dbdeb65b4fbc06c0ab424a72"
    sha256 cellar: :any_skip_relocation, big_sur:        "0a993c9e8d8cda4a2a55a6d066ea4cba01cf0cbbd4d54fe52afc964d31cb4e1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b297159b0dad9647243d1116f8dcbefbbbfcce937d650332f054e432bfbd0abe"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.Version=#{version}
    ]
    cd "src" do
      system "go", "build", *std_go_args(ldflags: ldflags)
    end

    prefix.install "themes"
    pkgshare.install_symlink prefix/"themes"
  end

  test do
    assert_match "oh-my-posh", shell_output("#{bin}/oh-my-posh --init --shell bash")
  end
end
