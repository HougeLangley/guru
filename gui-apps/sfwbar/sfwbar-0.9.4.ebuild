# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Sway Floating Window Bar"
HOMEPAGE="https://github.com/LBCrion/sfwbar"
SRC_URI="https://github.com/LBCrion/sfwbar/archive/v${PV}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	>=x11-libs/gtk+-3.22.0:3[introspection,wayland]
	gui-libs/gtk-layer-shell
	>=dev-libs/json-c-0.13:0=
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
	)
	meson_src_configure
}
