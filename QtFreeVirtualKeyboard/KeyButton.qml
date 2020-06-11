import QtQuick 2.0
import QtQuick.Controls 2.0

import FreeVirtualKeyboard 1.0

Button {
    id: root

    property alias backgroundColor: btnBackground.color
    property alias buttonRadius: btnBackground.radius

    property string buttonText
    property alias displayedText: btnText.text
    property alias textColor: btnText.color
    property alias textFont: btnText.font.family
    property alias textFontPixelSize: btnText.font.pixelSize

    property alias buttonIcon: btnIcon.source

    property var inputPanelRef
    property bool repeatable: false
    property bool showPreview: true
    property bool functionKey: false

    focusPolicy: Qt.NoFocus
    autoRepeat: repeatable

    contentItem: Item {
        Text {
            id: btnText

            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Image {
            id: btnIcon

            visible: btnText.text === ""
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
    }

    background: Rectangle {
        id: btnBackground
    }

    onPressed: {
        opacity = 0.7
        if (inputPanelRef !== null && showPreview) {
            inputPanelRef.showKeyPopup(root)
        }
    }

    onReleased: {
        opacity = 1
        if (!functionKey) {
            InputEngine.sendKeyToFocusItem(
                        buttonText === "" ? displayedText : buttonText)
        }
    }
}
