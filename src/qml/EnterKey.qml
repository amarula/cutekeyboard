import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    btnKey: Qt.Key_Enter
    repeatable: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    btnText: "\n"
    btnDisplayedText: InputPanel.enterIcon === "" ? "Enter" : ""
    btnIcon: InputPanel.enterIcon === "" ? "" : InputPanel.enterIcon
    enabled: InputContext.inputItem ? InputContext.inputItem.EnterKeyAction.enabled : true
    opacity: enabled ? 1 : 0.5
}
