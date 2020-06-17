QT += qml quick quick-private gui-private

CONFIG += plugin

TARGET = freevirtualkeyboardplugin
TEMPLATE = lib

SOURCES += \
    VirtualKeyboardInputContextPlugin.cpp \
    VirtualKeyboardInputContext.cpp \
    inputpaneliface.cpp \
    DeclarativeInputEngine.cpp

HEADERS += \
    VirtualKeyboardInputContextPlugin.h \
    VirtualKeyboardInputContext.h \
    inputpaneliface.hpp \
    DeclarativeInputEngine.h

RESOURCES += \
    resources.qrc

QML_FILES += \
    qml/qmldir \
    qml/*.qml

OTHER_FILES += $$QML_FILES

INSTALLS += \
    target \
    deployment

deployment.files = $$QML_FILES
deployment.path = $$[QT_INSTALL_QML]/QtQuick/FreeVirtualKeyboard
target.path = $$[QT_INSTALL_PLUGINS]/platforminputcontexts
