import CuteKeyboard 1.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Button {
    id: key

    objectName: inputPanelRef.objectName + "Key_" + (btnDisplayedText ? btnDisplayedText : btnText)

    property real weight: parent.keyWeight
    property string btnText: ""
    property string btnDisplayedText: text
    property int btnKey: Qt.Key_unknown
    property color btnBackground: InputPanel.btnBackgroundColor
    property int btnRadius: 5
    property color txtColor: InputPanel.btnTextColor
    property string txtFont: InputPanel.btnTextFontFamily
    property string btnIcon: ""
    property var alternativeKeys: []
    property var inputPanelRef
    property alias repeatable: key.autoRepeat
    property bool showPreview: true
    property bool functionKey: false

    focusPolicy: Qt.NoFocus
    Layout.minimumWidth: key.implicitWidth
    Layout.minimumHeight: key.implicitHeight
    Layout.preferredWidth: weight
    Layout.fillWidth: true
    Layout.fillHeight: true
    onPressed: {
        if (inputPanelRef !== null && showPreview)
            inputPanelRef.showKeyPopup(key);

    }
    onPressedChanged: {
        if (pressed) {
            opacity = 0.7;
            if (alternativeKeys.length > 0)
                longPressTimer.running = true;

        } else {
            opacity = 1;
            longPressTimer.running = false;
        }
    }
    onReleased: {
        if (!functionKey) {
            InputEngine.virtualKeyClick(btnKey, InputEngine.uppercase ? btnText.toUpperCase() : btnText, InputEngine.uppercase ? Qt.ShiftModifier : 0);
            if (!InputEngine.persistentUppercase)
                InputEngine.uppercase = false;
        }
    }

    Timer {
        id: longPressTimer

        interval: 800
        repeat: false
        running: false
        onTriggered: {
            enabled = false;
            inputPanelRef.hideKeyPopup();
            inputPanelRef.showAlternativesKeyPopup(key);
            enabled = true;
        }
    }

    background: Rectangle {
        id: btnBackgroundItem

        color: btnBackground
        radius: btnRadius
    }

    contentItem: Item {
        Text {
            id: btnTextItem

            text: btnDisplayedText == "" ? btnText : btnDisplayedText
            color: txtColor
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                family: txtFont
                weight: Font.Normal
                pixelSize: key.height * 0.4
                capitalization: InputEngine.uppercase ? Font.AllUppercase : Font.MixedCase
            }

        }

        Image {
            id: btnIconItem

            source: btnIcon
            visible: btnDisplayedText === ""
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }

    }

}
