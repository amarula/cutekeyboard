import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Key {
    functionKey: true
    showPreview: false
    onClicked: Qt.inputMethod.hide()
    btnBackground: Qt.darker(InputPanel.btnBackgroundColor)
    btnIcon: InputPanel.hideKeyboardIcon
}
