# Target system
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86)

# Toolchain binaries
set(CMAKE_C_COMPILER /users/paleshel/.local/bin/clang)
set(CMAKE_CXX_COMPILER /users/paleshel/.local/bin/clang++)
set(CMAKE_ASM_COMPILER /users/paleshel/.local/bin/clang)
set(CMAKE_AR /users/paleshel/.local/bin/llvm-ar)
set(CMAKE_STRIP /users/paleshel/.local/bin/llvm-strip)

set(CMAKE_CXX_FLAGS "--gcc-install-dir=/usr/lib/gcc/x86_64-linux-gnu/11")

# Sysroot for compiler and linker
# set(CMAKE_SYSROOT /home/zheng/.clang/sysroot)

# RPATH settings for runtime library search
# set(CMAKE_BUILD_RPATH "${CMAKE_SYSROOT}/usr/lib;${CMAKE_SYSROOT}/lib64;${CMAKE_SYSROOT}/lib")
# set(CMAKE_INSTALL_RPATH "${CMAKE_SYSROOT}/usr/lib;${CMAKE_SYSROOT}/lib64;${CMAKE_SYSROOT}/lib")
# set(CMAKE_SKIP_BUILD_RPATH FALSE)
# set(CMAKE_SKIP_INSTALL_RPATH FALSE)

set(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}")
set(CMAKE_FIND_ROOT_PATH "${CMAKE_INSTALL_PREFIX}")
# set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
