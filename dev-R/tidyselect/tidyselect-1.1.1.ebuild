# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Select from a Set of Strings'
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='GPL-3'
HOMEPAGE="
	https://tidyselect.r-lib.org
	https://github.com/r-lib/tidyselect
	https://cran.r-project.org/package=tidyselect
"
IUSE="${IUSE-}"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.2
	dev-R/ellipsis
	>=dev-R/glue-1.3.0
	>=dev-R/purrr-0.3.2
	>=dev-R/rlang-0.4.6
	>=dev-R/vctrs-0.3.0
"
RDEPEND="${DEPEND-}"
