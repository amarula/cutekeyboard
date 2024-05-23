import CuteKeyboard 1.0
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Button {
    id: key

    property real weight: parent.keyWeight
    property string btnText: ""
    property string btnDisplayedText: text
    property int btnKey: Qt.Key_unknown
    property color btnBackground: InputPanel.btnBackgroundColor
    property int btnRadius: 6
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
    Layout.preferredWidth: weight * 0.4
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
        if (!functionKey)
            InputEngine.virtualKeyClick(btnKey, InputEngine.uppercase ? btnText.toUpperCase() : btnText, InputEngine.uppercase ? Qt.ShiftModifier : 0);

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

        anchors.fill: parent
        anchors.topMargin: key.height * 0.07
        anchors.bottomMargin: key.height * 0.07
        anchors.leftMargin: key.height * 0.07
        anchors.rightMargin: key.height * 0.07
        color: btnBackground
        radius: btnRadius
    }

    contentItem: Item {

        Text {
            id: btnTextItem

            text: btnDisplayedText == "" ? btnText : btnDisplayedText
            color: txtColor
            anchors.centerIn: parent

            font {
                family: txtFont
                weight: Font.Normal
                pixelSize: key.height * 0.28
                capitalization: InputEngine.uppercase ? Font.AllUppercase : Font.MixedCase
            }

        }

        Image {
            id: btnIconItem

            source: btnIcon
            visible: btnDisplayedText === ""
            width: parent.width * 0.7
            height: parent.height * 0.7
            anchors.centerIn: parent

            fillMode: Image.PreserveAspectFit
        }

    }

}
