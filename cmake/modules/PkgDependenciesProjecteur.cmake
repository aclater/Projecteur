list(APPEND _PkgDeps_Projecteur_opensuse
  "libqt5-qtgraphicaleffects >= 5.7"
  "libQt5Widgets5 >= 5.7"
  "libQt5X11Extras5 >= 5.7"
  "shadow"
  "udev"
  "libusb-1_0-0"
)

list(APPEND _PkgDeps_Projecteur_fedora
  "qt5 >= 5.7"
  "passwd"
  "libusbx"
  "udev"
)

list(APPEND _PkgDeps_Projecteur_debian
  "qml-module-qtgraphicaleffects (>= 5.7)"
  "libqt5widgets5 (>= 5.7)"
  "libusb-1.0-0"
  "passwd"
  "udev"
)

list(APPEND _PkgDeps_Projecteur_archlinux
  "qt5-base>=5.7"
  "qt5-declarative>=5.7"
  "qt5-graphicaleffects>=5.7"
  "libusb"
  "udev"
)

list(APPEND _PkgDepsMake_Projecteur_archlinux
  "fakeroot" "awk" "cmake" "make" "lsb-release" "tar" "pkg-config" "qt5-tools"
)

list(APPEND PkgDependencies_MAP_Projecteur
  "debian::_PkgDeps_Projecteur_debian"
  "ubuntu::_PkgDeps_Projecteur_debian"
  "fedora::_PkgDeps_Projecteur_fedora"
  "opensuse::_PkgDeps_Projecteur_opensuse"
  "opensuse-leap::_PkgDeps_Projecteur_opensuse"
  "archlinux::_PkgDeps_Projecteur_archlinux"
  "arch::_PkgDeps_Projecteur_archlinux"
)

list(APPEND PkgDependenciesMake_MAP_Projecteur
  "archlinux::_PkgDepsMake_Projecteur_archlinux"
  "arch::_PkgDepsMake_Projecteur_archlinux"
)
