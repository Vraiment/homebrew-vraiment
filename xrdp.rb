# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Xrdp < Formula
  desc "xrdp: an open source RDP server"
  homepage "http://www.xrdp.org/"
  url "https://github.com/neutrinolabs/xrdp/releases/download/v0.9.4/xrdp-0.9.4.tar.gz"
  sha256 "059e362db550b58a108117e6538363d90f07edd0a54810affae977a6b0bb6ea7"

  depends_on "pkgconfig" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libtool"
  depends_on "openssl"
  depends_on "nasm"
  depends_on :x11

  def install
    ENV.deparallelize  # if your formula fails when building in parallel

    # Instructions for install grabbed from:
    # https://github.com/neutrinolabs/xrdp/wiki/Building-on-OSX
    system "autoreconf", "-fiv"
    system "./configure",
        "PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig",
        "--prefix=#{prefix}",
        "--sysconfdir=#{prefix}/etc",
        "--enable-strict-locations" # This is highly counter intuitive
                                    # but there is a bug in the configure file

    # Replace /etc to #{prefix}/etc
    #make_files = [
    #    "Makefile",
    #    "common/Makefile",
    #    "instfiles/Makefile",
    #    "instfiles/default/Makefile",
    #    "instfiles/init.d/Makefile",
    #    "instfiles/pam.d/Makefile",
    #    "instfiles/pulse/Makefile",
    #    "instfiles/rc.d/Makefile"
    #]
    #for file in make_files
        #ohai "Updating path to \"/etc\" in #{file}"
    #    etc_prefix = "#{prefix}".gsub("/", "\\/") + "\\/etc"
    #    system "sed",
    #        "-i.bak",
    #        "s/sysconfdir = \\/etc/sysconfdir = #{etc_prefix}/g",
    #        file
        #inreplace "Makefile" do |file_contents|
        #    file_contents.gsub! "sysconfdir = /etc/sysconfdir", "sysconfdir = #{prefix}/etc"
        #end
    #end
    #j_etc_prefix = "#{prefix}".gsub("/", "\\/") + "\\/etc"
    #system "sed",
    #    "-i.bak",
    #    "s/sysconfdir = \\/etc/sysconfdir = #{j_etc_prefix}/g",
    #    "Makefile"

    system "make"
    system "make","install"

    # Remove unrecognized options if warned by configure
    #system "./configure", "--disable-debug",
    #                      "--disable-dependency-tracking",
    #                      "--disable-silent-rules",
    #                      "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    #system "make", "install" # if this fails, try separate make/make install steps
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
