QT += qml quick quick-private gui-private

CONFIG += plugin

TARGET = freevirtualkeyboardplugin
TEMPLATE = lib

SOURCES += \
    VirtualKeyboardInputContextPlugin.cpp \
    VirtualKeyboardInputContext.cpp \
    DeclarativeInputEngine.cpp

HEADERS += \
    VirtualKeyboardInputContextPlugin.h\
    VirtualKeyboardInputContext.h \
    DeclarativeInputEngine.h

RESOURCES += \
    resources.qrc

INSTALLS += \
    target \
    deployment

deployment.files = *.qml qmldir
deployment.path = $$[QT_INSTALL_QML]/QtQuick/FreeVirtualKeyboard
target.path = $$[QT_INSTALL_PLUGINS]/platforminputcontexts
