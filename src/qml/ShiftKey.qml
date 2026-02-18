import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    objectName: inputPanelRef.objectName + "Key_Shift"
    btnKey: Qt.Key_Shift
    functionKey: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    btnIcon: InputEngine.uppercase ? InputPanel.shiftOnIcon : InputPanel.shiftOffIcon
    onClicked: InputEngine.uppercase = !InputEngine.uppercase
}
