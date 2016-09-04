# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="CFEngine policy files for Cryptoo"
HOMEPAGE="https://github.com/Cryptoo/cfengine"
LICENSE="MIT"

EGIT_REPO_URI="https://github.com/Cryptoo/cfengine.git"
EGIT_BRANCH="master"

SLOT="0"
KEYWORDS=""

DEPEND="
	app-admin/cfengine-masterfiles
	net-misc/cfengine:*"
RDEPEND="${DEPEND}"

IUSE="+client-only"

src_compile() { :; }

src_install() {
	if ! use client-only ; then
		CFENGINE_PREFIX="/var/cfengine/masterfiles"
		dodir "${CFENGINE_PREFIX}" || die
		cp -r "${S}/services" "${D}${CFENGINE_PREFIX}" || die
		cp -r "${S}/cryptoo" "${D}${CFENGINE_PREFIX}" || die
	fi

	CFENGINE_PREFIX="/var/cfengine/inputs"
	dodir "${CFENGINE_PREFIX}" || die
	cp -r "${S}/services" "${D}${CFENGINE_PREFIX}" || die
	cp -r "${S}/cryptoo" "${D}${CFENGINE_PREFIX}" || die
}
