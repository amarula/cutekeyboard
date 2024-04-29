QT += qml quick quick-private gui-private

CONFIG += plugin

TARGET = cutekeyboardplugin
TEMPLATE = lib

SOURCES += \
    EnterKeyAction.cpp \
    EnterKeyActionAttachedType.cpp \
    InputPanelIface.cpp \
    VirtualKeyboardInputContextPlugin.cpp \
    VirtualKeyboardInputContext.cpp \
    DeclarativeInputEngine.cpp

HEADERS += \
    EnterKeyAction.hpp \
    EnterKeyActionAttachedType.hpp \
    InputPanelIface.hpp \
    VirtualKeyboardInputContextPlugin.h \
    VirtualKeyboardInputContext.h \
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

!defined(INSTALL_PREFIX, var):INSTALL_PREFIX = $$[QT_INSTALL_PREFIX]

INSTALL_QML = $$INSTALL_PREFIX/$$relative_path($$[QT_INSTALL_QML], $$[QT_INSTALL_PREFIX])
INSTALL_PLUGINS = $$INSTALL_PREFIX/$$relative_path($$[QT_INSTALL_PLUGINS], $$[QT_INSTALL_PREFIX])

deployment.files = $$QML_FILES
deployment.path = $$INSTALL_QML/QtQuick/CuteKeyboard
target.path = $$INSTALL_PLUGINS/platforminputcontexts
