# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson systemd

COMMIT="73e16f76994b1d3c587796a35766cc668e30c0cd"

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
	insinto /etc/eg25-manager
	newins "${FILESDIR}"/eg25-pinephone-1.0.toml pine64,pinephone-1.0.toml
	newins "${FILESDIR}"/eg25-pinephone-1.1.toml pine64,pinephone-1.1.toml
	newins "${FILESDIR}"/eg25-pinephone-1.2.toml pine64,pinephone-1.2.toml
}

pkg_postinst() {
	systemd_reenable --all eg25-manager
}
