# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Sdl2pp < Formula
  desc "C++11 bindings/wrapper for SDL2"
  homepage "http://sdl2pp.amdmi3.ru"
  url "https://github.com/libSDL2pp/libSDL2pp/archive/0.14.1.tar.gz"
  sha256 "be2b2015a4127a1da280224ec3334090772ba7eaa83fc88225c9c11a0aa9a07a"

  depends_on "cmake" => :build
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "sdl2_ttf"

  def install
    # Generate Makefile
    system "cmake", "-DSDL2PP_WITH_IMAGE=ON",
                    "-DSDL2PP_WITH_MIXER=ON",
                    "-DSDL2PP_WITH_TTF=ON",
                    "-DSDL2PP_WITH_WERROR=OFF",
                    "-DSDL2PP_CXXSTD=c++11",
                    "-DSDL2PP_WITH_EXAMPLES=OFF",
                    "-DSDL2PP_WITH_TESTS=OFF",
                    "-DSDL2PP_STATIC=OFF",
                    "-DSDL2PP_ENABLE_LIVE_TESTS=OFF",
                    *std_cmake_args,
                    "."

    # Install
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test SDL2pp`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.

    # TODO: Write the test section

    # Generate Makefile
    #system "cmake", "-DSDL2PP_WITH_IMAGE=ON",
    #                "-DSDL2PP_WITH_MIXER=ON",
    #                "-DSDL2PP_WITH_TTF=ON",
    #                "-DSDL2PP_WITH_WERROR=OFF",
    #                "-DSDL2PP_CXXSTD=c++11",
    #                "-DSDL2PP_WITH_EXAMPLES=OFF",
    #                "-DSDL2PP_WITH_TESTS=ON",
    #                "-DSDL2PP_STATIC=OFF",
    #                "-DSDL2PP_ENABLE_LIVE_TESTS=OFF",
    #                ".", *std_cmake_args

    # Build tests
    #system "make -C tests"

    # Run tests
    #system "ctest tests"
  end
end
