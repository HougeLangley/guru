# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=OpenXR-SDK
inherit cmake

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/${MY_PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}"/${MY_PN}-${PV}
fi

DESCRIPTION="OpenXR loader"
HOMEPAGE="https://github.com/KhronosGroup/OpenXR-SDK"

LICENSE="Apache-2.0"
SLOT="0"

IUSE="+wayland +X"

BDEPEND=">=dev-util/cmake-3.10.2"
DEPEND="
	media-libs/vulkan-loader
	media-libs/mesa
	dev-libs/jsoncpp:=
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
	X? (
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
		x11-libs/libXrandr
		x11-libs/libXxf86vm
	)
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_SYSTEM_JSONCPP=ON
		-DBUILD_WITH_XLIB_HEADERS=$(usex X)
		-DBUILD_WITH_XCB_HEADERS=$(usex X)
		-DBUILD_WITH_WAYLAND_HEADERS=$(usex wayland)
	)

	cmake_src_configure
}
