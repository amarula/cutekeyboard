import QtQuick 2.0
import QtQml 2.0

import FreeVirtualKeyboard 1.0

Item {
    id: root
    objectName: "inputPanel"

    property bool active: Qt.inputMethod.visible

    property color backgroundColor: "#000000"
    property color btnBackgroundColor: "#808080"
    property color btnSpecialBackgroundColor: Qt.darker("#808080")
    property color btnTextColor: "#ffffff"
    property string btnTextFontFamily

    property string languageLayout: "En"

    property string backspaceIcon: "qrc:/icons/backspace.png"
    property string enterIcon: ""
    property string shiftOnIcon: "qrc:/icons/caps-lock-on.png"
    property string shiftOffIcon: "qrc:/icons/caps-lock-off.png"
    property string hideKeyboardIcon: "qrc:/icons/hide-arrow.png"

    width: parent.width
    height: width / 4

    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))

    function showKeyPopup(keyButton) {
        keyPopup.popup(keyButton, root)
    }

    function loadLettersLayout() {
        if (InputEngine.inputLayoutValid(languageLayout)) {
            layoutLoader.setSource(languageLayout + "Layout.qml", {
                                       "inputPanel": root
                                   })
        } else {
            layoutLoader.setSource("EnLayout.qml", {
                                       "inputPanel": root
                                   })
        }
    }

    onLanguageLayoutChanged: loadLettersLayout()

    Component.onCompleted: {
        InputPanel.backgroundColor = backgroundColor
        InputPanel.btnBackgroundColor = btnBackgroundColor
        InputPanel.btnSpecialBackgroundColor = btnSpecialBackgroundColor
        InputPanel.btnTextColor = btnTextColor
        InputPanel.btnTextFontFamily = btnTextFontFamily
        InputPanel.backspaceIcon = backspaceIcon
        InputPanel.enterIcon = enterIcon
        InputPanel.shiftOnIcon = shiftOnIcon
        InputPanel.shiftOffIcon = shiftOffIcon
        InputPanel.hideKeyboardIcon = hideKeyboardIcon

        loadLettersLayout()
    }

    KeyPopup {
        id: keyPopup

        popupColor: btnBackgroundColor
        popupTextColor: btnTextColor
        popupTextFont: btnTextFontFamily
        visible: false
        z: 100
    }

    Rectangle {
        id: keyboardRect

        color: InputPanel.backgroundColor
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
        }

        Loader {
            id: layoutLoader

            anchors {
                fill: parent
                margins: 5
            }
        }

        Connections {
            target: InputEngine

            function refreshLayouts() {
                if (InputEngine.symbolMode) {
                    layoutLoader.setSource("SymbolLayout.qml", {
                                               "inputPanel": root
                                           })
                } else if (InputEngine.inputMode === InputEngine.DigitsOnly) {
                    layoutLoader.setSource("DigitsLayout.qml", {
                                               "inputPanel": root
                                           })
                } else {
                    loadLettersLayout()
                }
            }

            onInputModeChanged: refreshLayouts()
            onIsSymbolModeChanged: refreshLayouts()
        }
    }
}
