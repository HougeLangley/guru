# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_BINARY=cmake
CMAKE_MAKEFILE_GENERATOR=emake

MYPV="${PV/_beta/-beta}"
MYPN="${PN}"
MYP="${MYPN}-${MYPV}"

DESCRIPTION="API Generator for Database acces."
HOMEPAGE="https://github.com/azaeldevel/apidb"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+mariadb postgresql commands gtk +corelibs"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libxml2
	dev-libs/boost
	dev-libs/octetos-coreutils
	sys-devel/bison
	sys-devel/flex
	gtk? ( x11-libs/gtk+ )
	dev-libs/libtar
	mariadb? ( dev-libs/octetos-db-maria )
	postgresql? ( dev-libs/octetos-db-postgresql )
	media-gfx/imagemagick
"

S="${WORKDIR}/${PN}-${MYPV}"

src_prepare() {
	sed -i 's/lib/${LIBDIR}/' src/CMakeLists.txt || die
	sed -i 's/lib/${LIBDIR}/' src/mysql-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/mariadb-reader-c++/CMakeLists.txt  || die
	sed -i 's/lib/${LIBDIR}/' src/postgresql-reader-c++/CMakeLists.txt  || die

	cmake_src_prepare
}

src_configure() {
	APIDBBUILD="CORE"
	APIDBINSTALL=""
	if use corelibs ;then
		APIDBINSTALL="CORE"
	fi
	if use mariadb ;then
		APIDBBUILD="$APIDBBUILD;MARIADB"
		APIDBINSTALL="$APIDBINSTALL;DRIVERS"
	fi
	if use postgresql ;then
		APIDBBUILD="$APIDBBUILD;POSTGRESQL"
		APIDBINSTALL="$APIDBINSTALL;DRIVERS"
	fi
	if use commands ;then
		APIDBINSTALL="$APIDBINSTALL;COMMANDS"
	fi
	if use gtk ;then
		APIDBINSTALL="$APIDBINSTALL;GTK3"
	fi
	local mycmakeargs=(-DAPIDB_VERSION_STAGE=alpha -DPLATFORM=LINUX_GENTOO -DAPIDBBUILD=$APIDBBUILD -DAPIDBINSTALL=$APIDBINSTALL)
	cmake_src_configure
}
