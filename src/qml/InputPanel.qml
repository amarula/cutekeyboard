import CuteKeyboard 1.0
import QtQml 2.0
import QtQuick 2.0

Item {
    id: root

    property bool active: Qt.inputMethod.visible
    property color backgroundColor: "#000000"
    property color btnBackgroundColor: "#383533"
    property color btnSpecialBackgroundColor: "#23211E"
    property color btnTextColor: "#ffffff"
    property string btnTextFontFamily: "Sans"
    property string languageLayout: "En"
    property string backspaceIcon: "qrc:/images/backspace.svg"
    property string enterIcon: "qrc:/images/enter.svg"
    property string shiftOnIcon: "qrc:/images/shift-green.svg"
    property string shiftOffIcon: "qrc:/images/shift-grey.svg"
    property string hideKeyboardIcon: "qrc:/images/hidekeyboard.svg"
    property string languageIcon: "qrc:/images/globe.svg"
    property var availableLanguageLayouts: ["En"]

    function showKeyPopup(keyButton) {
        keyPopup.popup(keyButton, root);
    }

    function hideKeyPopup() {
        keyPopup.visible = false;
    }

    function showAlternativesKeyPopup(keyButton) {
        alternativesKeyPopup.open(keyButton, root);
    }

    function loadLettersLayout() {
        if (InputEngine.inputLayoutValid(languageLayout))
            layoutLoader.setSource(languageLayout + "Layout.qml", {
                                       "inputPanel": root
                                   });
        else
            layoutLoader.setSource("EnLayout.qml", {
                                       "inputPanel": root
                                   });
    }

    objectName: "inputPanel"
    width: parent.width
    height: width / 3.2
    onYChanged: InputEngine.setKeyboardRectangle(Qt.rect(x, y, width, height))
    onActiveChanged: {
        if (alternativesKeyPopup.visible && !active)
            alternativesKeyPopup.visible = false;

    }
    onLanguageLayoutChanged: loadLettersLayout()
    Component.onCompleted: {

        if (availableLanguageLayouts.length == 0)
            availableLanguageLayouts = ["En"];

        InputPanel.backgroundColor = backgroundColor;
        InputPanel.btnBackgroundColor = btnBackgroundColor;
        InputPanel.btnSpecialBackgroundColor = btnSpecialBackgroundColor;
        InputPanel.btnTextColor = btnTextColor;
        InputPanel.btnTextFontFamily = btnTextFontFamily;
        InputPanel.backspaceIcon = backspaceIcon;
        InputPanel.enterIcon = enterIcon;
        InputPanel.shiftOnIcon = shiftOnIcon;
        InputPanel.shiftOffIcon = shiftOffIcon;
        InputPanel.hideKeyboardIcon = hideKeyboardIcon;
        InputPanel.languageIcon = languageIcon;
        InputPanel.availableLanguageLayouts = availableLanguageLayouts;
        InputPanel.languageLayout = languageLayout;
        loadLettersLayout();
    }

    KeyPopup {
        id: keyPopup

        popupColor: btnBackgroundColor
        popupTextColor: btnTextColor
        popupTextFont: btnTextFontFamily
        visible: false
        z: 100
    }

    AlternativeKeysPopup {
        id: alternativesKeyPopup

        visible: false
        z: 100
    }

    MouseArea {
        id: alternativesKeyPopupMouseArea

        visible: alternativesKeyPopup.visible
        enabled: visible
        anchors.fill: parent
        propagateComposedEvents: false
        z: 99
    }

    Rectangle {
        id: keyboardRect

        color: InputPanel.backgroundColor
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
        }

        Loader {
            id: layoutLoader

            anchors {
                fill: parent
                topMargin: 2
                leftMargin: 35
                rightMargin: 40
                bottomMargin: 25
            }

        }

        Connections {
            function refreshLayouts() {
                if (InputEngine.symbolMode)
                    layoutLoader.setSource("SymbolLayout.qml", {
                                               "inputPanel": root
                                           });
                else if (InputEngine.inputMode === InputEngine.DigitsOnly)
                    layoutLoader.setSource("DigitsLayout.qml", {
                                               "inputPanel": root
                                           });
                else
                    loadLettersLayout();
            }

            function onInputModeChanged() {
                refreshLayouts();
            }

            function onIsSymbolModeChanged() {
                refreshLayouts();
            }

            target: InputEngine
        }

        Connections {
            target: InputPanel
            onLanguageLayoutChanged: {
                languageLayout = InputPanel.languageLayout;
                loadLettersLayout();
            }
        }

    }

}
