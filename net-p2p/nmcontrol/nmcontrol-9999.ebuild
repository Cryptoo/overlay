# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 git-2

DESCRIPTION="NMControl is a plugin architecture for Namecoin"
HOMEPAGE="https://github.com/namecoin/nmcontrol"

EGIT_REPO_URI="git://github.com/namecoin/nmcontrol.git"

SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="doc"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS} net-dns/namecoind"
RDEPEND="${DEPEND}"

src_compile() { :; }

src_install() {
	# Install python modules
	
	cd ${S}
	python_setup
	cd ${S}/lib/DNS
	python_moduleinto ${PN}/lib/DNS
	python_domodule Base.py Class.py Lib.py Opcode.py Status.py Type.py lazy.py __init__.py
	cd ${S}/lib/dnsServer
	python_moduleinto ${PN}/lib/dnsServer
	python_domodule listdns.py namecoindns.py utils.py __init__.py
	cd ${S}/lib
	python_moduleinto ${PN}/lib
	python_domodule backendDataFile.py backendDataNamecoin.py common.py console.py daemonize.py platformDep.py plugin.py rpcClient.py
	cd ${S}/plugin
	python_moduleinto ${PN}/plugin
	python_domodule pluginData.py pluginDns.py pluginGuiHttp.py pluginGuiHttpConfig.py pluginMain.py pluginNamespaceDomain.py pluginRpc.py
	cd ${S}/service
	python_moduleinto ${PN}/service
	python_domodule serviceDNS.py serviceHTTP.py
	cd ${S}
	python_moduleinto ${PN}
	python_domodule nmcontrol.py

	# Install README
	if use doc ; then
		dodoc README.md
	fi

	# Create wrapper	
	echo "#!/bin/bash" > "${T}/${PN}"
	echo "cd $(python_get_sitedir)/${PN}" >> "${T}/${PN}"
	echo "exec python2 $(python_get_sitedir)/${PN}/nmcontrol.py $@" >> "${T}/${PN}"
	dobin "${T}/${PN}"

	# nmcontrol is badly behaving because it wants to write access to its install directories. Try to make it a bit nicer.
	
	dodir /var/lib/namecoin/.config/nmcontrol/conf /var/lib/namecoin/.config/nmcontrol/data
	chown -R namecoin:namecoin ${D}/var/lib/namecoin/
	chmod -R 750 ${D}/var/lib/namecoin/
	dosym /var/lib/namecoin/.config/nmcontrol/conf $(python_get_sitedir)/${PN}
	dosym /var/lib/namecoin/.config/nmcontrol/data $(python_get_sitedir)/${PN}
}
