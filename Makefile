all: extract

.PHONY: clean
.PHONY: extract

NDK=android-ndk-r10d
OS=darwin-x86_64
ANDROID_PLATFORM=19
STL=llvm-libc++
TOOLCHAIN=gcc
TOOLCHAIN_VERSION=4.9
ARCH=armeabi-v7a

NDK_ARCHIVE=${NDK}-${OS}.bin

#Android platform
FILES += ${NDK}/platforms/android-${ANDROID_PLATFORM}

#Standard libraries
FILES += ${NDK}/sources/cxx-stl/${STL}
EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/.gitignore

#Toolchains
ifeq (${TOOLCHAIN},gcc)
	GCC_VERSION=${TOOLCHAIN_VERSION}
else ifeq (${TOOLCHAIN},clang)
	CLANG=clang${TOOLCHAIN_VERSION}
	FILES += ${NDK}/toolchains/llvm-${TOOLCHAIN_VERSION}
	GCC_VERSION=4.8
endif

#Select files by architecture
ifneq (,$(filter arm64-v8a,${ARCH}))
	FILES += ${NDK}/toolchains/aarch64-linux-android-${GCC_VERSION}
	FILES += ${NDK}/toolchains/aarch64-linux-android-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/arm64-v8a
endif
ifneq (,$(filter armeabi,${ARCH}))
	FILES += ${NDK}/toolchains/arm-linux-androideabi-${GCC_VERSION}
	FILES += ${NDK}/toolchains/arm-linux-androideabi-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/armeabi
endif
ifneq (,$(filter armeabi-v7a,${ARCH}))
	FILES += ${NDK}/toolchains/arm-linux-androideabi-${GCC_VERSION}
	FILES += ${NDK}/toolchains/arm-linux-androideabi-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/armeabi-v7a
endif
ifneq (,$(filter armeabi-v7a-hard,${ARCH}))
	FILES += ${NDK}/toolchains/arm-linux-androideabi-${GCC_VERSION}
	FILES += ${NDK}/toolchains/arm-linux-androideabi-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/armeabi-v7a-hard
endif
ifneq (,$(filter mips,${ARCH}))
	FILES += ${NDK}/toolchains/mipsel-linux-android-${GCC_VERSION}
	FILES += ${NDK}/toolchains/mipsel-linux-android-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/mips
endif
ifneq (,$(filter mips64,${ARCH}))
	FILES += ${NDK}/toolchains/mipsel64el-linux-android-${GCC_VERSION}
	FILES += ${NDK}/toolchains/mipsel64el-linux-android-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/mips64
endif
ifneq (,$(filter x86,${ARCH}))
	FILES += ${NDK}/toolchains/x86-${GCC_VERSION}
	FILES += ${NDK}/toolchains/x86-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/x86
endif
ifneq (,$(filter x86_64,${ARCH}))
	FILES += ${NDK}/toolchains/x86_64-${GCC_VERSION}
	FILES += ${NDK}/toolchains/x86_64-${CLANG}
else
	EXCLUDES += ${NDK}/sources/cxx-stl/${STL}/libs/x86_64
endif

#Unaltered files
FILES += ${NDK}/build
FILES += ${NDK}/prebuilt
FILES += ${NDK}/sources/cpufeatures
FILES += ${NDK}/sources/android
FILES += ${NDK}/sources/third_party
FILES += ${NDK}/tests
FILES += ${NDK}/GNUmakefile
FILES += ${NDK}/README.TXT
FILES += ${NDK}/RELEASE.TXT
FILES += ${NDK}/find-win-host.cmd
FILES += ${NDK}/ndk-build
FILES += ${NDK}/ndk-build.cmd
FILES += ${NDK}/ndk-depends
FILES += ${NDK}/ndk-gdb
FILES += ${NDK}/ndk-gdb-py
FILES += ${NDK}/ndk-gdb-py.cmd
FILES += ${NDK}/ndk-gdb.py
FILES += ${NDK}/ndk-stack
FILES += ${NDK}/ndk-which
FILES += ${NDK}/remove-windows-symlink.sh

#Unused python files
EXCLUDES += ${NDK}/prebuilt/${OS}/lib

clean: 
	@echo Cleaning all NDK files...
	rm -rf ${NDK}
	@echo Done cleaning.

${NDK_ARCHIVE}:
	@echo Downloading NDK archive...
	wget http://dl.google.com/android/ndk/${NDK_ARCHIVE}

extract: ${NDK_ARCHIVE}
	@echo Extracting...
	7z x ${NDK_ARCHIVE} ${FILES} | egrep -v Skipping
	@echo Done extracting.
	@echo Cleaning up...
	rm -rf ${EXCLUDES}
	@echo Done.


