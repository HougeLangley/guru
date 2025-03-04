# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Transparent Checkpointing Library"
HOMEPAGE="https://github.com/bsc-pm/TCL"
SRC_URI="https://github.com/bsc-pm/TCL/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug fti instrumentation scr veloc"

RDEPEND="
	virtual/mpi

	fti? ( sys-cluster/fti )
	scr? ( sys-cluster/scr )
	veloc? ( sys-cluster/veloc )
"
DEPEND="${RDEPEND}"
REQUIRED_USE="|| ( fti scr veloc )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-static
		--enable-shared
		--includedir="${EPREFIX}/usr/include/TCL"
		--with-mpi="${EPREFIX}/usr"

		$(use_enable debug)
		$(use_enable instrumentation)
	)

	if use debug && use instrumentation; then
		myconf+=( "--enable-instrumentation-debug" )
	else
		myconf+=( "--disable-instrumentation-debug" )
	fi
	if use fti; then
		myconf+=( "--with-fti=${EPREFIX}/usr" )
	else
		myconf+=( "--without-fti" )
	fi
	if use scr; then
		myconf+=( "--with-scr=${EPREFIX}/usr" )
	else
		myconf+=( "--without-scr" )
	fi
	if use veloc; then
		myconf+=( "--with-veloc=${EPREFIX}/usr" )
	else
		myconf+=( "--without-veloc" )
	fi

	econf "${myconf[@]}"
}

src_install() {
	default
	dodoc NEWS AUTHORS INSTALL
	find "${ED}" -name '*.la' -delete || die
}
