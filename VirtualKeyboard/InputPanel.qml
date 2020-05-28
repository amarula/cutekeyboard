import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Item {
    id: root
    objectName: "inputPanel"

    property color backgroundColor: "#000000"
    property color buttonBackgroundColor: "#808080"
    property color buttonTextColor: "#ffffff"

    width: parent.width
    height: width / 4

    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))

    KeyModel {
        id: keyModel
    }

    FontLoader {
        source: "FontAwesome.otf"
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
            displayedText: (pimpl.shiftModifier) ? letter.toUpperCase(
                                                       ) : (pimpl.symbolModifier) ? firstSymbol : letter
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
        console.log("showKeyPopup")
        keyPopup.popup(keyButton, root)
    }

    KeyPopup {
        id: keyPopup
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
                    font.family: "FontAwesome"
                    displayedText: "\uf062"
                    functionKey: true
                    inputPanelRef: root
                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor

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

                    font.family: "FontAwesome"
                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    anchors.right: parent.right
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    buttonText: "\x7F"
                    displayedText: "\uf177"
                    inputPanelRef: root
                    repeatable: true
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
                    font.family: "FontAwesome"
                    displayedText: "\uf078"
                    functionKey: true
                    inputPanelRef: root
                    showPreview: false

                    onClicked: {
                        Qt.inputMethod.hide()
                    }
                }
                KeyButton {
                    id: emptyKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: ""
                    inputPanelRef: root
                    functionKey: true
                }
                KeyButton {
                    id: commaKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: ","
                    inputPanelRef: root
                }
                KeyButton {
                    id: spaceKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 3 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: " "
                    inputPanelRef: root
                    showPreview: false
                }
                KeyButton {
                    id: dotKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: "."
                    inputPanelRef: root
                }
                KeyButton {
                    id: symbolKey

                    backgroundColor: buttonBackgroundColor
                    textColor: buttonTextColor
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: (!pimpl.symbolModifier) ? "12#" : "ABC"
                    functionKey: true
                    onClicked: {
                        if (pimpl.shiftModifier) {
                            pimpl.shiftModifier = false
                        }
                        pimpl.symbolModifier = !pimpl.symbolModifier
                    }
                    inputPanelRef: root
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
                }
            }
        }
    }
}
