# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.1.5"
PKG_SHA256="ca23407fe8169c9ca8c439fcc8ac143230da056678df279220ebf0c10091678a"
PKG_LICENSE="MIT"
PKG_SITE="https://waf.io"
PKG_URL="https://waf.io/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_LONGDESC="The Waf build system"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  cp -pf ${PKG_BUILD}/waf ${TOOLCHAIN}/bin/
}
