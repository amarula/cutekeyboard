import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Item {
    id: root
    objectName: "inputPanel"

    property color backgroundColor: "#000000"

    property color buttonBackgroundColor: "#808080"
    property color buttonTextColor: "#ffffff"
    property string buttonsTextFontFamily
    property int buttonsRadius: 0

    property string backspaceIcon: "qrc:/Icons/backspace.png"
    property string capsLockOffIcon: "qrc:/Icons/caps-lock-off.png"
    property string capsLockOnIcon: "qrc:/Icons/caps-lock-on.png"
    property string hideKeyboardIcon: "qrc:/Icons/hide-arrow.png"

    width: parent.width
    height: width / 4

    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))

    KeyModel {
        id: keyModel
    }

    QtObject {
        id: pimpl
        property bool shiftModifier: false
        property bool symbolModifier: false
        property int verticalSpacing: keyboardRect.height / 40
        property int horizontalSpacing: verticalSpacing
        property int rowHeight: keyboardRect.height / 4 - verticalSpacing
        property int buttonWidth: (keyboardRect.width - column.anchors.margins)
                                  / 10 - horizontalSpacing
        property int buttonsTextPixelSize: keyboardRect.height / 8
    }

    Component {
        id: keyButtonDelegate

        KeyButton {
            id: button

            width: pimpl.buttonWidth
            height: pimpl.rowHeight
            inputPanelRef: root
            backgroundColor: buttonBackgroundColor
            textColor: buttonTextColor
            textFont: buttonsTextFontFamily
            textFontPixelSize: pimpl.buttonsTextPixelSize
            buttonRadius: buttonsRadius

            displayedText: {
                if (pimpl.symbolModifier) {
                    firstSymbol
                } else if (pimpl.shiftModifier) {
                    letter.toUpperCase()
                } else {
                    letter
                }
            }
        }
    }

    Connections {
        target: InputEngine
        onInputModeChanged: {
            pimpl.symbolModifier = ((InputEngine.inputMode == InputEngine.Numeric)
                                    || (InputEngine.inputMode == InputEngine.Dialable))
            if (pimpl.symbolModifier) {
                pimpl.shiftModifier = false
            }
        }
    }

    function showKeyPopup(keyButton) {
        keyPopup.popup(keyButton, root)
    }

    KeyPopup {
        id: keyPopup

        popupColor: buttonBackgroundColor
        popupTextColor: buttonTextColor
        popupTextFont: buttonsTextFontFamily
        visible: false
        z: 100
    }

    Rectangle {
        id: keyboardRect

        color: backgroundColor
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
        }

        Column {
            id: column
            anchors.margins: 5
            anchors.fill: parent
            spacing: pimpl.verticalSpacing

            Row {
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    model: keyModel.firstRowModel
                    delegate: keyButtonDelegate
                }
            }
            Row {
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter: parent.horizontalCenter
                Repeater {
                    model: keyModel.secondRowModel
                    delegate: keyButtonDelegate
                }
            }
            Item {
                height: pimpl.rowHeight
                width: parent.width

                KeyButton {
                    id: shiftKey

                    anchors.left: parent.left
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    functionKey: true
                    inputPanelRef: root
                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    buttonIcon: pimpl.shiftModifier ? capsLockOnIcon : capsLockOffIcon
                    showPreview: false
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius

                    onClicked: {
                        if (pimpl.symbolModifier) {
                            pimpl.symbolModifier = false
                        }
                        pimpl.shiftModifier = !pimpl.shiftModifier
                    }
                }
                Row {
                    height: pimpl.rowHeight
                    spacing: pimpl.horizontalSpacing
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        anchors.horizontalCenter: parent.horizontalCenter
                        model: keyModel.thirdRowModel
                        delegate: keyButtonDelegate
                    }
                }
                KeyButton {
                    id: backspaceKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    anchors.right: parent.right
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    buttonText: "\x7F"
                    buttonIcon: backspaceIcon
                    inputPanelRef: root
                    repeatable: true
                    showPreview: false
                    buttonRadius: buttonsRadius
                }
            }
            Row {
                height: pimpl.rowHeight
                spacing: pimpl.horizontalSpacing
                anchors.horizontalCenter: parent.horizontalCenter
                KeyButton {
                    id: hideKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    functionKey: true
                    inputPanelRef: root
                    showPreview: false
                    buttonIcon: hideKeyboardIcon
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius

                    onClicked: {
                        Qt.inputMethod.hide()
                    }
                }
                KeyButton {
                    id: commaKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: ","
                    inputPanelRef: root
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius
                }
                KeyButton {
                    id: spaceKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 4 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    buttonText: " "
                    displayedText: "space"
                    inputPanelRef: root
                    showPreview: false
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius
                }
                KeyButton {
                    id: dotKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: "."
                    inputPanelRef: root
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius
                }
                KeyButton {
                    id: symbolKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: (!pimpl.symbolModifier) ? "12#" : "ABC"
                    functionKey: true
                    inputPanelRef: root
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius

                    onClicked: {
                        if (pimpl.shiftModifier) {
                            pimpl.shiftModifier = false
                        }
                        pimpl.symbolModifier = !pimpl.symbolModifier
                    }
                }
                KeyButton {
                    id: enterKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: "Enter"
                    buttonText: "\n"
                    inputPanelRef: root
                    textFont: buttonsTextFontFamily
                    textFontPixelSize: pimpl.buttonsTextPixelSize
                    buttonRadius: buttonsRadius
                }
            }
        }
    }
}
