#!/bin/bash

RPM_PKG_DIR=$(dirname $(readlink -f $0))
RPM_PKG_NAME=$(basename $RPM_PKG_DIR)
RPM_SPEC_FILE=SPECS/${RPM_PKG_NAME}.spec

if [ -d SOURCES ]; then
	cd SOURCES
	find . -type f -printf '\%{__install} -D -m644 %P\t\t \%{buildroot}/%P\n' | tr -d '\\' >> ../$RPM_SPEC_FILE
	find . -type f -printf '/%P\n' | tr -d '\\' >> ../$RPM_SPEC_FILE
	cd -
else
	mkdir -p BUILD BUILDROOT RPMS SOURCES SPECS SRPMS 2>/dev/null
fi

