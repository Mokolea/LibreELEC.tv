# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vulkan-loader"
PKG_VERSION="1.4.322"
PKG_SHA256="a754012c4a3d2cc2b07bd9b49f9bd8255e880a7e66d779495d8859bdca8e4ed5"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Loader"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3:host vulkan-headers"
PKG_LONGDESC="Vulkan Installable Client Driver (ICD) Loader."

configure_package() {
  # Displayserver Support
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" libxcb libX11 libXrandr"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_DEPENDS_TARGET+=" wayland"
  fi
}

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTS=OFF"

  # GAS / GNU Assembler is only supported by aarch64 & x86_64
  if [ "${ARCH}" = "arm" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_GAS=OFF"
  fi

  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=ON \
                             -DBUILD_WSI_XLIB_SUPPORT=ON \
                             -DBUILD_WSI_WAYLAND_SUPPORT=OFF"
  elif [ "${DISPLAYSERVER}" = "wl" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=OFF \
                             -DBUILD_WSI_XLIB_SUPPORT=OFF \
                             -DBUILD_WSI_WAYLAND_SUPPORT=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XCB_SUPPORT=OFF \
                             -DBUILD_WSI_XLIB_SUPPORT=OFF \
                             -DBUILD_WSI_WAYLAND_SUPPORT=OFF"
  fi
}
