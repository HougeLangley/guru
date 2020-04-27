# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Tool to check the completeness of MANIFEST.in for Python packages"
HOMEPAGE="
	https://github.com/mgedmin/check-manifest
	https://pypi.org/project/check-manifest
"
SRC_URI="https://github.com/mgedmin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

#install requires, is right?
RDEPEND="
	dev-python/pep517[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

python_test() {
	nosetests -v -e test_build_sdist || die
}
