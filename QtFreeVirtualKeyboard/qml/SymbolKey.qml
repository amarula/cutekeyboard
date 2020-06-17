import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Key {
    btnKey: Qt.Key_Context1
    btnDisplayedText: !InputEngine.symbolMode ? "&123" : "ABC"
    functionKey: true
    showPreview: false
    btnBackground: Qt.darker(InputPanel.btnBackgroundColor)
    onClicked: InputEngine.symbolMode = !InputEngine.symbolMode
}
