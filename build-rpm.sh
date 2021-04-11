#!/bin/bash

die(){
	echo -e $1
	exit $2
}

use(){
	die "Use: $0 '<Changelog message description>'" 1
}

get_git_user_name(){
	git config --local --get user.name
}

get_git_user_email(){
	git config --local --get user.email
}

if [ $# -ne 1 ]; then
	use
fi

RPM_PKG_DIR=$(dirname $(readlink -f $0))
RPM_PKG_NAME=$(basename $RPM_PKG_DIR)
RPM_SPEC_FILE=SPECS/${RPM_PKG_NAME}.spec
RPM_BUILD_LOG_FILE=${RPM_PKG_NAME}.log

RPM_CHANGELOG_ENTRY=$1


RPM_GIT_USER=$(get_git_user_name)
RPM_GIT_EMAIL=$(get_git_user_email)

if [ -z "$RPM_GIT_USER" ]; then
	die "Git user name not set. Please set it with git config --local --add user.name 'User name'" 2
fi

if [ -z "$RPM_GIT_EMAIL" ]; then
	die "Git user email not set. Please set it with git config --local --add user.email 'user@mail'" 2
fi

RPM_CHANGELOG_USER="$RPM_GIT_USER ($RPM_GIT_EMAIL)"

rpmdev-bumpspec -c "$RPM_CHANGELOG_ENTRY" -u "$RPM_CHANGELOG_USER" \
	$RPM_SPEC_FILE

rpmbuild \
	-D "_topdir $RPM_PKG_DIR" \
	-D "%_build_name_fmt %%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm" \
	-bb $RPM_SPEC_FILE 2>&1 | tee $RPM_BUILD_LOG_FILE

