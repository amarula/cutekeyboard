import CuteKeyboard 1.0
import QtQuick 2.0

Key {
    objectName: inputPanelRef.objectName + "Key_Language"
    weight: 108.5
    btnKey: Qt.Key_Context2
    btnIcon: InputPanel.languageIcon
    functionKey: true
    showPreview: false
    btnBackground: InputPanel.btnSpecialBackgroundColor
    onClicked: {
        var indx = InputPanel.availableLanguageLayouts.indexOf(InputPanel.languageLayout);
        if (indx != -1) {
            var nextIndx = (indx + 1) % InputPanel.availableLanguageLayouts.length;
            var nextLangLayout = InputPanel.availableLanguageLayouts[nextIndx];
            if (InputEngine.inputLayoutValid(nextLangLayout))
                InputPanel.languageLayout = nextLangLayout;
            else
                InputPanel.languageLayout = "En";
        } else {
            InputPanel.languageLayout = InputPanel.availableLanguageLayouts[0];
        }
    }
}
