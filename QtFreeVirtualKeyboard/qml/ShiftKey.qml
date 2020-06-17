import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Key {
    btnKey: Qt.Key_Shift
    functionKey: true
    showPreview: false
    btnBackground: Qt.darker(InputPanel.btnBackgroundColor)
    btnIcon: InputEngine.uppercase ? InputPanel.shiftOnIcon : InputPanel.shiftOffIcon
    onClicked: InputEngine.uppercase = !InputEngine.uppercase
}
