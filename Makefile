all: trim

.PHONY: clean
.PHONY: extract

NDK=android-ndk-r10d
NDK_ARCHIVE=${NDK}-darwin-x86_64.bin

#Android platforms
FILES += ${NDK}/platforms/android-19
#Standard libraries
FILES += ${NDK}/sources/cxx-stl/llvm-libc++
FILES += ${NDK}/sources/cxx-stl/llvm-libc++abi
FILES += ${NDK}/sources/cxx-stl/gabi++
FILES += ${NDK}/sources/cxx-stl/system
#Toolchains
FILES += ${NDK}/toolchains/arm-linux-androideabi-4.9
FILES += ${NDK}/toolchains/x86-4.9
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

EXCLUDES += ${NDK}/sources/cxx-stl/llvm-libc++/.gitignore
EXCLUDES += ${NDK}/sources/cxx-stl/gabi++/.gitignore
EXCLUDES += ${NDK}/prebuilt/darwin-x86_64/lib

clean: 
	@echo Cleaning all NDK files...
	rm -rf ${NDK}
	@echo Done cleaning.

${NDK_ARCHIVE}:
	@echo Downloading NDK archive...
	wget http://dl.google.com/android/ndk/${NDK_ARCHIVE}

extract:
	@echo Extracting...
	7z x ${NDK_ARCHIVE} ${FILES} | egrep -v Skipping
	@echo Done extracting.
	@echo Cleaning up...
	rm -rf ${EXCLUDES}
	@echo Done.


