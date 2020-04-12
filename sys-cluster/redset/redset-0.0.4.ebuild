# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="Low-level distributed erasure coding lib to protect datasets of MPI applications"
HOMEPAGE="https://github.com/ECP-VeloC/redset"
SRC_URI="https://github.com/ECP-VeloC/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	virtual/mpi
	sys-cluster/KVTree[mpi]
	sys-cluster/rankstr
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-util/cmake-2.8
"

src_prepare() {
	#do not build static library
	sed -i '/redset-static/d' src/CMakeLists.txt
	default
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	dodoc -r doc/rst/.
}
