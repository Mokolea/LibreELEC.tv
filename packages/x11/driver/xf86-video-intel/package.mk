# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-intel"
PKG_VERSION="ce811e78882d9f31636351dfe65351f4ded52c74"
PKG_SHA256="b68c91f93a3bb4ff6aba1184b468c88b7403135b0e1518616f20c6dd8acb18e1"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="https://www.x.org/wiki/IntelGraphicsDriver/"
PKG_URL="https://gitlab.freedesktop.org/xorg/driver/${PKG_NAME}/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libXcomposite libXxf86vm libXdamage libdrm util-macros systemd xorg-server"
PKG_LONGDESC="Open-source Xorg graphics driver for Intel graphics."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-backlight \
                           --disable-backlight-helper \
                           --disable-gen4asm \
                           --enable-udev \
                           --disable-tools \
                           --enable-dri \
                           --disable-dri1 \
                           --enable-dri2 \
                           --enable-dri3 \
                           --enable-kms --enable-kms-only \
                           --disable-ums --disable-ums-only \
                           --enable-sna \
                           --enable-uxa \
                           --disable-xvmc \
                           --disable-xaa \
                           --disable-dga \
                           --disable-tear-free \
                           --disable-create2 \
                           --disable-async-swap \
                           --with-xorg-module-dir=${XORG_PATH_MODULES}"

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --with-default-dri=3"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --with-default-dri=2"
fi

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/polkit-1
}
