# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Xorgxrdp < Formula
  desc "Xorg drivers for xrdp"
  homepage "http://www.xrdp.org/"
  url "https://github.com/neutrinolabs/xorgxrdp/releases/download/v0.2.5/xorgxrdp-0.2.5.tar.gz"
  sha256 "37397caae6751366c472a6f80a458fee3107d5489868c71efea584e514b54b70"

  depends_on "pkgconfig" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "xrdp"
  depends_on :x11

  def install
    # Instructions for install grabbed from:
    # https://github.com/neutrinolabs/xrdp/wiki/Building-on-OSX

    # Following line is equivalent to ./bootstrap
    system "autoreconf", "-fiv"

    system "./configure",
        "PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig",
        "--prefix=#{prefix}",
        "--sysconfdir=#{prefix}/etc",
        "--enable-strict-locations" # This is highly counter intuitive
                                    # but there is a bug in the configure file,
                                    # this DISABLES strict locations

    system "make"
    system "make", "install"
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
