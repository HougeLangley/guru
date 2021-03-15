# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit cmake check-reqs python-single-r1

DESCRIPTION="A fast very high compression read-only FUSE file system"
HOMEPAGE="https://github.com/mhx/dwarfs"

SRC_URI="https://github.com/mhx/dwarfs/releases/download/v${PV}/dwarfs-${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="python +jemalloc"

#test IUSE disabled because there is no googletest in portage tree at this moment
#-DWITH_TESTS=$(usex test ON OFF)

PYTHON_REQ_USE="python"

DEPEND="sys-devel/flex
		sys-devel/binutils:*"
RDEPEND="dev-libs/boost[context,threads,python?]
		dev-libs/double-conversion
		dev-libs/libfmt
		dev-libs/libevent
		dev-libs/xxhash
		jemalloc? ( >=dev-libs/jemalloc-5.2.1 )
		app-arch/libarchive
		app-arch/zstd
		app-arch/lz4
		app-arch/xz-utils
		app-arch/snappy
		dev-cpp/sparsehash
		dev-cpp/gflags
		dev-cpp/glog[gflags]
		sys-fs/fuse:3
		sys-libs/binutils-libs
		sys-libs/zlib
		sys-libs/libunwind
		!dev-cpp/folly"
BDEPEND="app-text/ronn
		dev-util/cmake
		sys-apps/sed
		sys-devel/bison
		virtual/pkgconfig"

CHECKREQS_DISK_BUILD="1300M"

DOCS=( "README.md" "CHANGES.md" "TODO" )

CMAKE_IN_SOURCE_BUILD=1
CMAKE_WARN_UNUSED_CLI=0

src_prepare(){
	cmake_src_prepare
	einfo "setting library path to $(get_libdir)"
	sed "s/DESTINATION lib/DESTINATION $(get_libdir)/" -i CMakeLists.txt || die
}

src_configure(){
	einfo "setting configuration flags to:"
	mycmakeargs=(
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DWITH_PYTHON=$(usex python ON OFF)
		-DPREFER_SYSTEM_ZSTD=1
		-DPREFER_SYSTEM_XXHASH=1
		-DWITH_LEGACY_FUSE=0
	)
	if use python; then mycmakeargs+=( -DWITH_PYTHON_VERSION=${EPYTHON#python} ); fi
	einfo ${mycmakeargs}
	cmake_src_configure
}

src_install(){
	cmake_src_install
	dolib.so libmetadata_thrift.so libthrift_light.so
	dolib.so folly/libfolly.so.0.58.0-dev folly/libfolly.so
}

pkg_postinst(){
	elog "Since version 0.4.1 GGC builds has been fixed. Now both Clang and GCC are working very well"
	elog "You may find more information in the"
	elog "${HOMEPAGE}"
	elog "About creating: ${HOMEPAGE}/blob/main/doc/mkdwarfs.md"
	elog "About mounting: ${HOMEPAGE}/blob/main/doc/dwarfs.md"
}
