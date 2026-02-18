import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    objectName: inputPanelRef.objectName + "Key_Backspace"
    btnKey: Qt.Key_Backspace
    repeatable: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    btnIcon: InputPanel.backspaceIcon
}
