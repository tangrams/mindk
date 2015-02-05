all: trim

.PHONY clean
.PHONY trim

NDK_VERSION="r10d"
NDK_ARCHIVE="android-ndk-${NDK_VERSION}-darwin-x86_64.bin"
ANDROID_PLATFORMS="android-17|android-18|android-19|android-21"
STDLIBS="llvm-libc++|llvm-libc++abi|gabi++|system"
TOOLCHAINS=".*clang3\.5|.*llvm-3\.5"

clean: 
	echo "Cleaning all NDK files..."
	ls | grep -v "${NDK_ARCHIVE}|Makefile" | xargs rm -rf
	echo "Done cleaning."

${NDK_ARCHIVE}:
	echo "Downloading NDK archive..."
	wget http://dl.google.com/android/ndk/${NDK_ARCHIVE}

RELEASE.TXT: ${NDK_ARCHIVE}
	echo "Expanding NDK archive..."
	chmod a+x ${NDK_ARCHIVE}
    ./${NDK_ARCHIVE}
    echo "Done expanding."

trim: RELEASE.TXT
	echo "Trimming NDK..."
	echo "Trimming Platforms..."
	ls platforms | egrep -v $ANDROID_PLATFORMS | xargs rm -rf
	echo "Trimming cxx-stl..."
	ls sources/cxx-stl | egrep -v $STDLIBS | xargs rm -rf
	echo "Trimming toolchains..."
	ls toolchains | egrep -v $TOOLCHAINS | xargs rm -rf
	echo "Done trimming."



