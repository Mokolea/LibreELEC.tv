# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gettext"
PKG_VERSION="0.26"
PKG_SHA256="d1fb86e260cfe7da6031f94d2e44c0da55903dbae0a2fa0fae78c91ae1b56f00"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/s/gettext/"
PKG_URL="https://ftp.gnu.org/pub/gnu/gettext/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="make:host"
PKG_DEPENDS_TARGET="autotools:host make:host gcc:host"
PKG_LONGDESC="A program internationalization library and tools."
PKG_BUILD_FLAGS="+local-cc"

PKG_CONFIGURE_OPTS_HOST="--disable-static --enable-shared \
                         --disable-rpath \
                         --with-gnu-ld \
                         --disable-java \
                         --disable-curses \
                         --with-included-libxml \
                         --disable-native-java \
                         --disable-csharp \
                         --without-emacs"

PKG_CONFIGURE_OPTS_TARGET="--disable-rpath"

post_configure_target() {
  libtool_remove_rpath gettext-runtime/libasprintf/libtool
  libtool_remove_rpath gettext-tools/libtool
}
