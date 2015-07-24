# mindk

mindk is just a makefile that enumerates, downloads, and extracts the minimal set of files necessary from the Android NDK for a given build configuration. In the makefile there are options for NDK version, host OS, Android API level, C++ STL, compiler toolchain, and cpu architecture(s). 

The goal here is to generate compact NDK distributions for use in automated builds. Using just one of each of the configuration options, the NDK shrinks from about 4GB to under 250MB, much more reasonable for downloads.
