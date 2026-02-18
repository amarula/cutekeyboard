import QtQuick 2.0

Key {
    objectName: inputPanelRef.objectName + "Key_Space"
    btnKey: Qt.Key_Space
    btnText: " "
    showPreview: false
    repeatable: true

    property bool showLanguageDescription: true
    btnDisplayedText: {
        if (emptySpaceBar) {
            return "";
        }
        return showLanguageDescription ? langDescription : spaceIdentifier;
    }
}
