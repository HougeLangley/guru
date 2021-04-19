# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8} )
inherit font python-any-r1

DESCRIPTION="A IBM 3270 Terminal font in a modern format"
HOMEPAGE="https://github.com/rbanffy/3270font"
SRC_URI="https://github.com/rbanffy/3270font/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD CC-BY-SA-3.0 GPL-3 OFL"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

DOCS=( CHANGELOG.md README.md  )
HTML_DOCS=( "DESCRIPTION.en_us.html" )

PATCHES=( "${FILESDIR}/remove-useless-tests.patch" )
RDEPEND="
	media-gfx/fontforge
"
DEPEND="
	${PYTHON_DEPS}
	${RDEPEND}
	test? (
		$(python_gen_any_dep '
			dev-python/ipdb[${PYTHON_USEDEP}]
			dev-python/pillow[${PYTHON_USEDEP}]
		')
	)
"

FONT_S="${S}/build"
FONT_SUFFIX="otf ttf pfm woff"

python_check_deps() {
	has_version -d "dev-python/ipdb[${PYTHON_USEDEP}]" &&
	has_version -d "dev-python/pillow[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_compile() {
	emake font
}

src_test() {
	emake test
}
