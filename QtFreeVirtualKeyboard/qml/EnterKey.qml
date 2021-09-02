import QtQuick 2.0

import FreeVirtualKeyboard 1.0

Key {
    btnKey: Qt.Key_Enter
    repeatable: true
    showPreview: false
    btnBackground: Qt.darker(InputPanel.btnBackgroundColor)
    btnText: "\n"
    btnDisplayedText: "Enter"
    enabled: InputContext.focusItemHasEnterKeyAction(
                 InputContext.inputItem) ? InputContext.inputItem.EnterKeyAction.enabled : true
    opacity: enabled ? 1 : 0.5
}
