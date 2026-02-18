import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    objectName: inputPanelRef.objectName + "Key_Hide"
    functionKey: true
    showPreview: false
    onClicked: Qt.inputMethod.hide()
    btnBackground: InputPanel.btnSpecialBackgroundColor
    btnIcon: InputPanel.hideKeyboardIcon
}
