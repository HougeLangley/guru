# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd

COMMIT="f2593b62b10513f94039d5c9ba995905b23e7eb4"

DESCRIPTION="Daemon for managing the Quectel EG25 modem"
HOMEPAGE="https://gitlab.com/mobian1/devices/eg25-manager"
SRC_URI="https://gitlab.com/mobian1/devices/eg25-manager/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~arm64"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/libgpiod
	virtual/libusb:1
	net-misc/modemmanager
"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	meson_src_install
	systemd_dounit "${FILESDIR}"/eg25-manager.service
}

pkg_postinst() {
	systemd_reenable --all eg25-manager
}
