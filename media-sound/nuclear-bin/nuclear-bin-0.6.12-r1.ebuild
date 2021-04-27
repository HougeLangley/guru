# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

MY_PV="v${PV}"
MY_P="nuclear-${MY_PV}"

DESCRIPTION="Nuclear is a streaming program that pulls content from free sources on internet"
HOMEPAGE="https://nuclear.js.org/"
SRC_URI="https://github.com/nukeop/nuclear/releases/download/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}"

DEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	dev-libs/atk
	dev-libs/libappindicator
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	media-libs/mesa
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libdrm
	x11-libs/libnotify
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libxshmfence
	x11-libs/libXtst
	x11-libs/pango
"

QA_PREBUILT="/opt/nuclear-bin/*"

src_prepare(){
	default
}

src_install(){
	insinto /opt/"${PN}"
	doins -r "${S}"/*
	dosym ../../opt/"${PN}"/nuclear "${EPREFIX}"/usr/bin/nuclear
	fperms +x /opt/"${PN}"/nuclear
	fperms +x /opt/"${PN}"/chrome-sandbox
	fperms +x /opt/"${PN}"/resources/bin/fpcalc
	make_desktop_entry "/opt/${PN}/nuclear %U" "Nuclear" "nuclear" \
		"Audio;Music;Player;AudioVideo;" \
		"GenericName=Nuclear-bin\nStartupNotify=true\nStartupWMClass=nuclear"
	cd "${S}"/resources/media/ || die
	mv icon.icns nuclear.icns || die
	doicon nuclear.icns
	cd presskit/icons/color || die
	for i in {16,24,32,48,64,96,128,256,512}; do
		mv "${i}".png nuclear-"${i}".png || die
		doicon -s "${i}" nuclear-"${i}".png
	done
	cd ../scalable || die
	mv nuclear-icon.svg nuclear.svg || die
	doicon nuclear.svg
}

pkg_postinst(){
	xdg_desktop_database_update
	xdg_icon_cache_update
}
