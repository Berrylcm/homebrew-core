require "language/node"

class Asyncapi < Formula
  desc "All in one CLI for all AsyncAPI tools"
  homepage "https://github.com/asyncapi/cli"
  url "https://registry.npmjs.org/@asyncapi/cli/-/cli-0.34.2.tgz"
  sha256 "5b4fa8aa95318e1a8841c73bffcc042d88eac7527f4295b327d5450289ac6a23"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "0999ad95c690021db8a8e73190c6b04633bfbb0593a479c32e3eb94938d09e1e"
    sha256 cellar: :any,                 arm64_monterey: "0999ad95c690021db8a8e73190c6b04633bfbb0593a479c32e3eb94938d09e1e"
    sha256 cellar: :any,                 arm64_big_sur:  "0999ad95c690021db8a8e73190c6b04633bfbb0593a479c32e3eb94938d09e1e"
    sha256 cellar: :any,                 ventura:        "00686f93c207014252c800cef3b6462ae1f1edbda7712542c1e3c59678ca61bf"
    sha256 cellar: :any,                 monterey:       "00686f93c207014252c800cef3b6462ae1f1edbda7712542c1e3c59678ca61bf"
    sha256 cellar: :any,                 big_sur:        "00686f93c207014252c800cef3b6462ae1f1edbda7712542c1e3c59678ca61bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5fb8a7d09629f313c0ec6119bded28a36c1b443e0f908c126d9738a12fbfadf"
  end

  depends_on "node"

  def install
    # Call rm -f instead of rimraf, because devDeps aren't present in Homebrew at postpack time
    inreplace "package.json", "rimraf oclif.manifest.json", "rm -f oclif.manifest.json"
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Delete native binaries installed by npm, as we dont support `musl` for a `libc` implementation
    node_modules = libexec/"lib/node_modules/@asyncapi/cli/node_modules"
    (node_modules/"@swc/core-linux-x64-musl/swc.linux-x64-musl.node").unlink if OS.linux?

    # Replace universal binaries with their native slices
    deuniversalize_machos
  end

  test do
    system bin/"asyncapi", "new", "--file-name=asyncapi.yml", "--example=default-example.yaml", "--no-tty"
    assert_predicate testpath/"asyncapi.yml", :exist?, "AsyncAPI file was not created"
  end
end
