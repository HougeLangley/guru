# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

MYPV="${PV/_/}"

DESCRIPTION="Extensions for Python Markdown."
HOMEPAGE="
	https://github.com/facelessuser/pymdown-extensions
	https://pypi.org/project/pymdown-extensions
"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc"

RDEPEND=">=dev-python/markdown-3.2[${PYTHON_USEDEP}]"

BDEPEND="
	doc? (
		dev-python/mkdocs-git-revision-date-localized-plugin
		dev-python/mkdocs-material
		dev-python/pymdown-lexers
		dev-python/pyspelling
	)
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${PN}-${MYPV}"

distutils_enable_tests pytest

python_compile_all() {
	default
	if use doc; then
		mkdocs build || die "failed to make docs"
		HTML_DOCS="site"
	fi
}
