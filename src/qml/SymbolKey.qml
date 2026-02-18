import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    objectName: inputPanelRef.objectName + "Key_Symbol"
    btnKey: Qt.Key_Context1
    btnDisplayedText: !InputEngine.symbolMode ? "&123" : "ABC"
    functionKey: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    onClicked: InputEngine.symbolMode = !InputEngine.symbolMode
}
