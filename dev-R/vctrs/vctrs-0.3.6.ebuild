# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Vector Helpers'
HOMEPAGE="
	https://github.com/r-lib/vctrs
	https://cran.r-project.org/package=vctrs
"
SRC_URI="http://cran.r-project.org/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='GPL-3'

IUSE="${IUSE-}"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.3
	dev-R/digest
	>=dev-R/ellipsis-0.2.0
	dev-R/glue
	>=dev-R/rlang-0.4.7
"
RDEPEND="${DEPEND-}"
