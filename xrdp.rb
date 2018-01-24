# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Xrdp < Formula
  desc "xrdp: an open source RDP server"
  homepage "http://www.xrdp.org/"
  url "https://github.com/neutrinolabs/xrdp/releases/download/v0.9.5/xrdp-0.9.5.tar.gz"
  sha256 "0c66b06204237745be3f0a75bfdd22a2b27de97740490256964bb5082efb0042"

  depends_on "pkgconfig" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl"
  depends_on "nasm"
  depends_on :x11

  def install
    # Instructions for install grabbed from:
    # https://github.com/neutrinolabs/xrdp/wiki/Building-on-OSX

    # Set PKG_CONFIG_PATH variable
    ENV.prepend_path "PKG_CONFIG_PATH", "#{Formula["openssl"].opt_lib}/pkgconfig"

    # Following line is equivalent to ./bootstrap
    system "autoreconf", "-fiv"

    system "./configure",
        "--prefix=#{prefix}",
        "--sysconfdir=#{prefix}/etc",
        "--enable-strict-locations" # This is highly counter intuitive
                                    # but there is a bug in the configure file,
                                    # this DISABLES strict locations

    system "make"
    system "make", "install"

    # Update the .ini file, not needed?
    #config_file = "#{prefix}/etc/xrdp/xrdp.ini"
    #ohai "Updating configuration file..."
    #inreplace config_file, ".so", ".dylib"

    # Copy & configure script, source:
    # https://forums.macrumors.com/threads/how-to-control-your-mac-using-win-rdp-client-xrdp-compiling-guide-on-osx.1770325/
    script_path = "#{prefix}/bin/xrdp-cmd"
    system "cp", "instfiles/xrdp.sh", script_path
    ohai "Updating control script..."
    # Update paths
    inreplace script_path, "/usr/local/sbin", "#{prefix}/sbin"
    inreplace script_path, "/etc/xrdp", "#{prefix}/etc/xrdp"
    # Update logic to detect running servers
    inreplace script_path, "ps u --noheading -C xrdp | grep -q -i xrdp", "ps -A |grep -qi xrdp$"
    inreplace script_path, "ps u --noheading -C xrdp-sesman | grep -q -i xrdp-sesman", "ps -A |grep -qi xrdp-sesman$"

  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test xrdp`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    # system "false"
  end
end
