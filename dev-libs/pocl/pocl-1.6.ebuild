# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DOCS_AUTODOC=0
DOCS_BUILDER="sphinx"
DOCS_DIR="doc/sphinx/source"
PYTHON_COMPAT=( python3_{7..9} )

inherit cmake llvm python-any-r1 docs

LLVM_MAX_SLOT=11

DESCRIPTION="Portable Computing Language (an implementation of OpenCL)"
HOMEPAGE="
	http://portablecl.org
	https://github.com/pocl/pocl
"
SRC_URI="https://github.com/pocl/pocl/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="accel cl20 +conformance cuda debug examples float-conversion hardening +hwloc memmanager" #hsa tce

#TODO: add dependencies for cuda
RDEPEND="
	dev-libs/libltdl
	sys-devel/llvm:${LLVM_MAX_SLOT}
	virtual/opencl

	!cuda? ( sys-devel/clang:${LLVM_MAX_SLOT} )
	cuda? ( sys-devel/clang:${LLVM_MAX_SLOT}[llvm_targets_NVPTX] )
	debug? ( dev-util/lttng-ust )
	hwloc? ( sys-apps/hwloc[cuda?] )
"
DEPEND="
	${RDEPEND}
	doc? ( $(python_gen_any_dep '<dev-python/markupsafe-2.0[${PYTHON_USEDEP}]') )
"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/vendor_opencl_libs_location.patch" )

src_configure() {
	llvm_pkg_setup
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DENABLE_HSA=OFF
		-DENABLE_ICD=ON
		-DENABLE_POCL_BUILDING=OFF
		-DKERNELLIB_HOST_CPU_VARIANTS=native
		-DPOCL_ICD_ABSOLUTE_PATH=OFF
		-DSTATIC_LLVM=OFF

		-DENABLE_ACCEL_DEVICE=$(usex accel)
		-DENABLE_CONFORMANCE=$(usex conformance)
		-DENABLE_CUDA=$(usex cuda)
		-DENABLE_HOST_CPU_DEVICE_CL20=$(usex cl20)
		-DENABLE_HWLOC=$(usex hwloc)
		-DENABLE_POCL_FLOAT_CONVERSION=$(usex float-conversion)
		-DHARDENING_ENABLE=$(usex hardening)
		-DPOCL_DEBUG_MESSAGES=$(usex debug)
		-DUSE_POCL_MEMMANAGER=$(usex memmanager)
		-DWITH_LLVM_CONFIG=$(get_llvm_prefix "${LLVM_MAX_SLOT}")/bin/llvm-config
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	docs_compile
}

src_install() {
	cmake_src_install
	dodoc CREDITS README CHANGES
	if use doc; then
		dodoc -r _build/html
		docompress -x "/usr/share/doc/${P}/html"
	fi
	if use examples; then
		dodoc -r examples
		docompress -x "/usr/share/doc/${P}/examples"
	fi
}
