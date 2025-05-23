# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ncurses"
PKG_VERSION="6.5-20250517"
PKG_SHA256="13e78548b31adef93e3b9735bf728fac5a84969873333c7833614db61891353e"
PKG_LICENSE="MIT"
PKG_SITE="http://www.gnu.org/software/ncurses/"
PKG_URL="http://invisible-mirror.net/archives/ncurses/current/ncurses-${PKG_VERSION}.tgz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="autotools:host gcc:host zlib ncurses:host"
PKG_LONGDESC="A library is a free software emulation of curses in System V Release 4.0, and more."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--without-ada \
                           --without-cxx \
                           --without-cxx-binding \
                           --disable-db-install \
                           --without-manpages \
                           --without-progs \
                           --without-tests \
                           --without-shared \
                           --with-normal \
                           --without-debug \
                           --without-profile \
                           --without-termlib \
                           --without-ticlib \
                           --without-gpm \
                           --without-dbmalloc \
                           --without-dmalloc \
                           --disable-rpath \
                           --disable-database \
                           --with-fallbacks=linux,screen,xterm,xterm-color,dumb,st-256color \
                           --with-termpath=/storage/.config/termcap \
                           --disable-big-core \
                           --enable-termcap \
                           --enable-getcap \
                           --disable-getcap-cache \
                           --enable-symlinks \
                           --disable-bsdpad \
                           --without-rcs-ids \
                           --enable-ext-funcs \
                           --disable-const \
                           --enable-no-padding \
                           --disable-sigwinch \
                           --enable-pc-files \
                           --with-pkg-config-libdir=/usr/lib/pkgconfig \
                           --disable-tcap-names \
                           --without-develop \
                           --disable-hard-tabs \
                           --disable-xmc-glitch \
                           --enable-hashmap \
                           --disable-safe-sprintf \
                           --disable-scroll-hints \
                           --enable-widec \
                           --disable-echo \
                           --disable-warnings \
                           --disable-home-terminfo \
                           --disable-assertions \
                           --enable-leaks \
                           --enable-sigwinch \
                           --cache-file=config.cache"

PKG_CONFIGURE_OPTS_HOST="--enable-termcap \
                         --with-termlib \
                         --with-shared \
                         --enable-pc-files \
                         --without-manpages"

pre_configure_target() {
  cat >config.cache <<EOF
cf_cv_builtin_bool=yes
cf_cv_header_stdbool_h=yes
EOF
}

post_makeinstall_target() {
  local f
  cp misc/ncurses-config ${TOOLCHAIN}/bin
  chmod +x ${TOOLCHAIN}/bin/ncurses-config
  sed -e "s:\(['=\" ]\)/usr:\\1${PKG_ORIG_SYSROOT_PREFIX}/usr:g" -i ${TOOLCHAIN}/bin/ncurses-config
  rm -f ${TOOLCHAIN}/bin/ncurses6-config
  rm -rf ${INSTALL}/usr/bin
  # create links to be compatible with any ncurses include path and lib names
  ln -sf . ${SYSROOT_PREFIX}/usr/include/ncursesw
  ln -sf . ${SYSROOT_PREFIX}/usr/include/ncurses
  for f in form menu ncurses panel; do
    ln -sf lib${f}w.a ${SYSROOT_PREFIX}/usr/lib/lib${f}.a
    ln -sf ${f}w.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig/${f}.pc
  done
}
