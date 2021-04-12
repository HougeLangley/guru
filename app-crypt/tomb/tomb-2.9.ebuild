# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MYP="${P^}"
DESCRIPTION="Tomb :: File Encryption on GNU/Linux"
HOMEPAGE="https://www.dyne.org/software/tomb"
SRC_URI="https://files.dyne.org/tomb/releases/Tomb-${PV}.tar.gz"
LICENSE="
	GPL-3
	gui? ( GPL-3+ )
"
SLOT="0"
KEYWORDS="~amd64"
#todo extras/desktop extras/qt-tray extras/kdf
IUSE="gui test"
#test require sudo, can't be done non interactively
RESTRICT="test"
PATCHES=( "${FILESDIR}/gtomb.patch" )
DOCS=(
	AUTHORS.txt
	ChangeLog.txt
	KNOWN_BUGS.txt
	README.txt
	doc/bertini_thesis.pdf
	doc/HACKING.txt
	doc/KEY_SPECIFICATIONS.txt
	doc/LinuxHDEncSettings.txt
	doc/Luks_on_disk_format.pdf
	doc/New_methods_in_HD_encryption.pdf
	doc/TKS1-draft.pdf
	doc/tomb_manpage.pdf
)
S="${WORKDIR}/${MYP}"
RDEPEND="
	app-admin/sudo
	app-crypt/gnupg
	app-crypt/pinentry
	app-shells/zsh
	sys-fs/cryptsetup
	gui? ( gnome-extra/zenity )
"
BDEPEND="
	dev-python/pygments
	sys-devel/gettext
"
src_compile() {
	export PREFIX="${EPREFIX}/usr"
	emake

	#translations
	pushd extras/translations || die
	emake all
	popd || die

	#documentation
	cd doc/literate || die
	emake
}

src_install() {
	default

	#translations
	export PREFIX="${ED}/usr"
	pushd extras/translations || die
	emake install
	popd || die

	#zenity gui
	if use gui ; then
	pushd extras/gtomb || die
	dobin gtomb
	newdoc README.md README-gtomb
	popd || die
	fi

	#documentation
	einstalldocs
	cd doc/literate || die
	insinto "/usr/share/doc/${P}/html"
	doins -r *.html *.css public
}

src_test() {
	emake test
}
