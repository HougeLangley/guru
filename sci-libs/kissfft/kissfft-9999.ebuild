# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A Fast Fourier Transform (FFT) library that tries to Keep it Simple, Stupid"
HOMEPAGE="https://github.com/mborgerding/kissfft"

LICENSE="BSD"
IUSE="test"
RESTRICT="!test? ( test )"
SLOT="0"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/mborgerding/kissfft"
	inherit git-r3
else
	SRC_URI="https://github.com/mborgerding/kissfft/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="sci-libs/fftw:3.0"
RDEPEND="${DEPEND}"

src_install() {
	dolib.so libkissfft.so
	doheader kiss_fft.h
}

src_test() {
	make testall || die
}
