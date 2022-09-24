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

deployment.files = $$QML_FILES
deployment.path = $$[QT_INSTALL_QML]/QtQuick/CuteKeyboard
target.path = $$[QT_INSTALL_PLUGINS]/platforminputcontexts
