# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="
	https://geopy.readthedocs.io
	https://github.com/geopy/geopy
	https://pypi.org/project/geopy
"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<sci-geosciences/GeographicLib-2
	>=sci-geosciences/GeographicLib-1.49
"
BDEPEND="
	test? (
		dev-python/pytest-aiohttp[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs \
				dev-python/sphinx-issues \
				">=dev-python/sphinx_rtd_theme-0.4.0" \
				dev-python/readme_renderer

python_prepare_all() {
	# [Errno -3] Temporary failure in name resolution
	rm test/test_adapters.py || die
	rm test/geocoders/algolia.py || die
	rm test/geocoders/arcgis.py || die
	rm test/geocoders/banfrance.py || die
	rm test/geocoders/databc.py || die
	rm test/geocoders/geocodefarm.py || die
	rm test/geocoders/geonames.py || die
	rm test/geocoders/nominatim.py || die
	rm test/geocoders/photon.py || die

	# depend on the above and now fail to import
	rm test/geocoders/openmapquest.py || die
	rm test/geocoders/pickpoint.py || die

	distutils-r1_python_prepare_all
}
