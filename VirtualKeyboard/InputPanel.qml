import QtQuick 2.0

import FreeVirtualKeyboard 1.0


/**
 * This is the QML input panel that provides the virtual keyboard UI
 * The code has been derived from
 * http://tolszak-dev.blogspot.de/2013/04/qplatforminputcontext-and-virtual.html
 * Copyright 2015 Uwe Kindler
 * Licensed under MIT see LICENSE.MIT in project root
 */
Item {
    id: root
    objectName: "inputPanel"
    width: parent.width
    height: width / 4
    // Report actual keyboard rectangle to input engine
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
        property int verticalSpacing: keyboard.height / 40
        property int horizontalSpacing: verticalSpacing
        property int rowHeight: keyboard.height / 4 - verticalSpacing
        property int buttonWidth: (keyboard.width - column.anchors.margins) / 10 - horizontalSpacing
    }


    /**
     * The delegate that paints the key buttons
     */
    Component {
        id: keyButtonDelegate
        KeyButton {
            id: button
            width: pimpl.buttonWidth
            height: pimpl.rowHeight
            displayedText: (pimpl.shiftModifier) ? letter.toUpperCase(
                                                       ) : (pimpl.symbolModifier) ? firstSymbol : letter
            inputPanelRef: root
        }
    }

    Connections {
        target: InputEngine
        // Switch the keyboard layout to Numeric if the input mode of the InputEngine changes
        onInputModeChanged: {
            pimpl.symbolModifier = ((InputEngine.inputMode == InputEngine.Numeric)
                                    || (InputEngine.inputMode == InputEngine.Dialable))
            if (pimpl.symbolModifier) {
                pimpl.shiftModifier = false
            }
        }
    }


    /**
     * This function shows the character preview popup for each key button
     */
    function showKeyPopup(keyButton) {
        console.log("showKeyPopup")
        keyPopup.popup(keyButton, root)
    }


    /**
     * The key popup for character preview
     */
    KeyPopup {
        id: keyPopup
        visible: false
        z: 100
    }

    Rectangle {
        id: keyboard
        color: "black"
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
                    backgroundColor: (pimpl.shiftModifier) ? "#1e6fa7" : "#1e1b18"
                    anchors.left: parent.left
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    font.family: "FontAwesome"
                    displayedText: "\uf062"
                    functionKey: true
                    onClicked: {
                        if (pimpl.symbolModifier) {
                            pimpl.symbolModifier = false
                        }
                        pimpl.shiftModifier = !pimpl.shiftModifier
                    }
                    inputPanelRef: root
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
                    backgroundColor: "#1e1b18"
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
                    backgroundColor: "#1e1b18"
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    font.family: "FontAwesome"
                    displayedText: "\uf078"
                    functionKey: true
                    onClicked: {
                        Qt.inputMethod.hide()
                    }
                    inputPanelRef: root
                    showPreview: false
                }
                KeyButton {
                    backgroundColor: "#1e1b18"
                    width: 1.25 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: ""
                    inputPanelRef: root
                    functionKey: true
                }
                KeyButton {
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: ","
                    inputPanelRef: root
                }
                KeyButton {
                    id: spaceKey
                    width: 3 * pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: " "
                    inputPanelRef: root
                    showPreview: false
                }
                KeyButton {
                    width: pimpl.buttonWidth
                    height: pimpl.rowHeight
                    displayedText: "."
                    inputPanelRef: root
                }
                KeyButton {
                    id: symbolKey
                    backgroundColor: "#1e1b18"
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
                    backgroundColor: "#1e1b18"
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
