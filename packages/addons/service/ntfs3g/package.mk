# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ntfs3g"
PKG_REV="0"
PKG_LICENSE="GPLv3"
PKG_DEPENDS_TARGET="toolchain fuse ntfs-3g_ntfsprogs"
PKG_SECTION="service"
PKG_SHORTDESC="ntfs-3g for udevil"
PKG_LONGDESC="ntfs-3g for udevil"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="ntfs3g"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/{bin,lib.private}

  cp -PL $(get_install_dir fuse)/usr/lib/libfuse.so.2 \
    ${ADDON_BUILD}/${PKG_ADDON_ID}/lib.private

  cp $(get_install_dir ntfs-3g_ntfsprogs)/usr/bin/ntfs-3g \
    ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  patchelf --add-rpath '${ORIGIN}/../lib.private' ${ADDON_BUILD}/${PKG_ADDON_ID}/bin/ntfs-3g
}