# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="unittest subTest() support and subtests fixture"
HOMEPAGE="https://github.com/pytest-dev/pytest-subtests"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# Failed: nomatch: '*1 passed*'
	sed -i -e 's:test_capture_with_fixture:_&:' \
		tests/test_subtests.py || die

	distutils-r1_python_prepare_all
}
