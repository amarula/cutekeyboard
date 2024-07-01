import CuteKeyboard 1.0
import QtQml 2.0
import QtQuick 2.0

Item {
    id: root

    property bool active: Qt.inputMethod.visible
    property color backgroundColor: "#000000"
    property color btnBackgroundColor: "#808080"
    property color btnSpecialBackgroundColor: Qt.darker("#808080")
    property color btnTextColor: "#ffffff"
    property string btnTextFontFamily
    property string languageLayout: "En"
    property string backspaceIcon: "qrc:/icons/backspace.png"
    property string enterIcon: ""
    property string shiftOnIcon: "qrc:/icons/caps-lock-on.png"
    property string shiftOffIcon: "qrc:/icons/caps-lock-off.png"
    property string hideKeyboardIcon: "qrc:/icons/hide-arrow.png"
    property string languageIcon: "qrc:/icons/language.png"
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
        var description = InputEngine.descriptionOfLayout(languageLayout);
        var source = InputEngine.fileOfLayout(languageLayout);
        if (description !== "" && source !== "") {
            layoutLoader.langDescription = description;
            layoutLoader.setSource(source + ".qml", {
                "inputPanel": root
            });
        } else {
            layoutLoader.langDescription = "English";
            layoutLoader.setSource("EnLayout.qml", {
                "inputPanel": root
            });
        }
    }

    objectName: "inputPanel"
    width: parent.width
    height: width / 4
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

            // lang description only needed for layouts that share a file
            property string langDescription

            anchors {
                fill: parent
                margins: 5
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
            function onLanguageLayoutChanged() {
                languageLayout = InputPanel.languageLayout;
                loadLettersLayout();
            }

            target: InputPanel
        }

    }

}
