# This script is generated automatically by the release automation code in the
# Telepresence repository:
class Telepresence < Formula
  desc "Local dev environment attached to a remote Kubernetes cluster"
  homepage "https://telepresence.io"
  url "https://github.com/datawire/telepresence/archive/0.81.tar.gz"
  sha256 "461ae40d878d280eab31e39e9528d618df2a38f484740717540c25204dbfd827"

  depends_on "python3"
  depends_on "torsocks" => :run
  depends_on "sshfs" => :run

  include Language::Python::Virtualenv

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install "git+https://github.com/datawire/sshuttle.git@telepresence"
    bin.install libexec/"bin/sshuttle-telepresence"
    venv.pip_install_and_link buildpath
  end

  def caveats
    <<~EOS
      Use of the container method requires socat.
        brew install socat
    EOS
  end

  test do
    system "telepresence", "--help"
    system "sshuttle-telepresence", "--version"
  end
end
