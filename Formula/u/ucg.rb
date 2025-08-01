class Ucg < Formula
  desc "Tool for searching large bodies of source code (like grep)"
  homepage "https://gvansickle.github.io/ucg/"
  license "GPL-3.0-or-later"

  stable do
    url "https://github.com/gvansickle/ucg/releases/download/0.3.3/universalcodegrep-0.3.3.tar.gz"
    sha256 "116d832bbc743c7dd469e5e7f1b20addb3b7a08df4b4441d59da3acf221caf2d"

    # Fix Xcode 9 compilation issue: https://github.com/gvansickle/ucg/issues/118
    # Patch adapted from upstream: https://github.com/gvansickle/ucg/commit/395f89
    patch do
      url "https://raw.githubusercontent.com/Homebrew/formula-patches/00615b433f5d2e3eaaf0075fbf4c63d0d732f8c8/ucg/xcode9.patch"
      sha256 "3005fda5923cfa3093ce53ad84435fd7a5974f960b2e222e0e59afa90414af90"
    end

    # Backport fix for Linux
    # Ref: https://github.com/gvansickle/ucg/commit/619be108a10b49cb22441c1cbf378ea630237a2d
    patch :DATA
  end

  no_autobump! because: :requires_manual_review

  bottle do
    rebuild 1
    sha256 cellar: :any,                 sonoma:       "1cfae5edabc50ba8598a2212217b22f8d7b1d81c118f86e52ce94b1b889a98a4"
    sha256 cellar: :any,                 ventura:      "afbb657bc288953de91236ba95f3c609ba4e411e8602f0efda43770422436c43"
    sha256 cellar: :any,                 monterey:     "3ffc7fcd491433d72238d232acc46f48e08e1c85b40a147f67dabb7de8ec830d"
    sha256 cellar: :any,                 big_sur:      "ea472cd9d4ecff1791a8df22e8207387957cad4af9b367698887772b98f434ff"
    sha256 cellar: :any,                 catalina:     "2e18cfd35ea53d5326a69f3d21cf32c2e850cd864735e3e45cd645d85e350ec7"
    sha256 cellar: :any,                 mojave:       "2b073d5a0ee4cb2fe71822ce27c014b00974298cfc656f1fe0279f58bde398f9"
    sha256 cellar: :any,                 high_sierra:  "3642e741bc9ffd1cf1982bfc2c373e0ed54a417c08ac46f43e4cf8a09a0a1a8a"
    sha256 cellar: :any,                 sierra:       "dddf2d62a2e582a9356a4da6434ddb0432ce6d6b1d50a5dc6728f9b6254531a5"
    sha256 cellar: :any,                 el_capitan:   "e4699a681ae9d2e9d68ce7da85fc050907070bc9650fad0c4f76faf991f3a422"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2e2db85a685f30bdda52dbc415278d3e070fc3b8aa8dd5529cede481d5e5e8eb"
  end

  head do
    url "https://github.com/gvansickle/ucg.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on arch: :x86_64 # https://github.com/gvansickle/ucg/issues/123
  depends_on "pcre2"

  on_macos do
    depends_on "argp-standalone" => :build
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.txt").write("Hello World!")
    assert_match "Hello World!", shell_output("#{bin}/ucg 'Hello World' #{testpath}")
  end
end

__END__
diff --git a/src/libext/DoubleCheckedLock.hpp b/src/libext/DoubleCheckedLock.hpp
index fbce12f5d11fd384becb37fd43ce74d254fc4ac3..be06119bb8d0bb42be77bece750c40c6724606be 100644
--- a/src/libext/DoubleCheckedLock.hpp
+++ b/src/libext/DoubleCheckedLock.hpp
@@ -24,6 +24,7 @@

 #include <atomic>
 #include <functional>
+#include <mutex>

 /**
  * Function template implementing a double-checked lock.
