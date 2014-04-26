DESCRIPTION="Dummy package to provide virtual/flash"
KEYWORDS="x86 sparc amd64 ppc ppc64 alpha hppa mips ia64 arm"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"


IUSE=""
PROVIDE="virtual/flash"

DEPEND="|| ( www-plugins/adobe-flash www-plugins/gnash )"
RDEPEND="|| ( www-plugins/adobe-flash www-plugins/gnash )"

S="${WORKDIR}/${P}"

src_install() {
	einfo "******************************************************************"
	einfo " ${P} installed..."
	einfo " This ebuild does nothing except"
	einfo " satisfying virtual/flash dependencies"
	einfo "******************************************************************"
}
