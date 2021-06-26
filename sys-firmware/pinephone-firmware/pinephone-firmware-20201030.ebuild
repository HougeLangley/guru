# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Firmwares files for PinePhone"
HOMEPAGE="https://xff.cz/git/linux-firmware"
SRC_URI="https://github.com/scardracs/gentoo-packages/releases/download/${PV}/${P}.tar.gz"

LICENSE="linux-fw-redistributable no-source-code"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

S="${WORKDIR}"

src_install() {
	mkdir -p "${D}"/lib/firmware/ || die
	insinto /lib/firmware/
	doins anx7688-fw.bin
	doins ov5640-fw.bin
	doins rtl8723cs-fw.bin
}
