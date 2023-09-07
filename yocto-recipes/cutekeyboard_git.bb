require recipes-qt/qt5/qt5.inc
require recipes-qt/qt5/qt5-git.inc

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2f6f4d4f7d76b223f08e17122d04010f"

DEPENDS += "qtbase qtdeclarative qtmultimedia qtquickcontrols qtsvg qtxmlpatterns"

SRCREV = ${AUTOREV}
SRC_URI = "git://github.com/amarula/cutekeyboard.git;protocol=https;branch=main"

QMAKE_PROFILES += "${S}/src/src.pro"
