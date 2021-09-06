import QtQuick 2.0

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

    property string backspaceIcon: "qrc:/icons/backspace.png"
    property string shiftOnIcon: "qrc:/icons/caps-lock-on.png"
    property string shiftOffIcon: "qrc:/icons/caps-lock-off.png"
    property string hideKeyboardIcon: "qrc:/icons/hide-arrow.png"

    width: parent.width
    height: width / 4

    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))

    function showKeyPopup(keyButton) {
        keyPopup.popup(keyButton, root)
    }

    Component.onCompleted: {
        InputPanel.backgroundColor = backgroundColor
        InputPanel.btnBackgroundColor = btnBackgroundColor
        InputPanel.btnSpecialBackgroundColor = btnSpecialBackgroundColor
        InputPanel.btnTextColor = btnTextColor
        InputPanel.btnTextFontFamily = btnTextFontFamily
        InputPanel.backspaceIcon = backspaceIcon
        InputPanel.shiftOnIcon = shiftOnIcon
        InputPanel.shiftOffIcon = shiftOffIcon
        InputPanel.hideKeyboardIcon = hideKeyboardIcon
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

        QwertyLayout {
            inputPanel: root
            visible: InputEngine.inputMode === InputEngine.Qwerty
                     && !InputEngine.symbolMode
            anchors {
                fill: parent
                margins: 5
            }
        }

        SymbolLayout {
            inputPanel: root
            visible: InputEngine.inputMode === InputEngine.Qwerty
                     && InputEngine.symbolMode
            anchors {
                fill: parent
                margins: 5
            }
        }

        DigitsLayout {
            inputPanel: root
            visible: InputEngine.inputMode === InputEngine.DigitsOnly
            anchors {
                fill: parent
                margins: 5
            }
        }
    }
}
