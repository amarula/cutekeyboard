import QtQuick 2.0

import CuteKeyboard 1.0

Key {
    btnKey: Qt.Key_Shift
    functionKey: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    btnIcon: InputEngine.uppercase ? InputPanel.shiftOnIcon : InputPanel.shiftOffIcon
    onClicked: InputEngine.uppercase = !InputEngine.uppercase
}
