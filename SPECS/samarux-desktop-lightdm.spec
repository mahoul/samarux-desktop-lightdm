Name:           samarux-desktop-lightdm
Version:        0.1
Release:        4
Summary:        LightDM tweaks for samarux-desktop.
License:        GPL
Source: 	%{name}-%{version}.tar.gz
BuildRoot: 	%{_tmppath}/%{name}-%{version}-root
Packager: 	Enrique Gil (mahoul@gmail.com)
BuildArch:	noarch
BuildRequires:	rsync

%description
LightDM tweaks for samarux-desktop.

%prep
[ -d %{name} ] && rm -Rfv %{name}
[ -d %{_topdir}/SOURCES ] && rsync -avP --exclude '.git' --delete %{_topdir}/SOURCES/ .


%install
%{__install} -D -m644 etc/lightdm/lightdm.conf.d/i3-gnome.conf		 %{buildroot}/etc/lightdm/lightdm.conf.d/i3-gnome.conf
%{__install} -D -m644 var/lib/lightdm/.config/fontconfig/fonts.conf		 %{buildroot}/var/lib/lightdm/.config/fontconfig/fonts.conf


%clean


%files
%defattr(-, root, root)
/etc/lightdm/lightdm.conf.d/i3-gnome.conf
/var/lib/lightdm/.config/fontconfig/fonts.conf

%changelog
* Sat Apr 10 2021 Enrique Gil (mahoul@gmail.com) - 0.1-4
- Renamed package to samarux-desktop-lightdm

* Mon Mar 29 2021 Enrique Gil (mahoul@gmail.com) - 0.1-3
- Set i3-gnome as default session

* Sun Mar 28 2021 Enrique Gil (mahoul@gmail.com) - 0.1-2
- Initial package build

* Sat Mar 27 2021 Enrique Gil (mahoul@gmail.com) - 0.1-1
- Initial release.

