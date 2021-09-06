import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Key {
    btnKey: Qt.Key_Enter
    repeatable: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    btnText: "\n"
    btnDisplayedText: InputPanel.enterIcon === "" ? "Enter" : ""
    btnIcon: InputPanel.enterIcon === "" ? "" : InputPanel.enterIcon
    enabled: InputContext.focusItemHasEnterKeyAction(
                 InputContext.inputItem) ? InputContext.inputItem.EnterKeyAction.enabled : true
    opacity: enabled ? 1 : 0.5
}
