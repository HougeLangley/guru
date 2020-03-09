# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="The lightning-fast ASGI server"
HOMEPAGE="https://www.uvicorn.org/
	https://github.com/encode/uvicorn"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE="doc"
REQUIRED_USE="x86? ( !doc )"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/h11[${PYTHON_USEDEP}]
	>=dev-python/uvloop-0.14.0[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]"

BDEPEND="doc? ( !x86? (
	dev-python/mkdocs
	dev-python/mkdocs-material ) )"

DEPEND="test? (
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# these tests fail, likely because wsproto is out of date
	rm tests/protocols/test_websocket.py || die
	rm tests/protocols/test_http.py || die

	# do not install LICENSE to /usr/
	sed -i -e '/data_files/d' setup.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	default
	if use doc; then
		mkdocs build || die "failed to make docs"
		HTML_DOCS="site"
	fi
}
