import CuteKeyboard 1.0
import QtQuick 2.0

Item {
    id: root

    property color popupColor
    property alias popupTextColor: txt.color
    property alias popupTextFont: txt.font.family
    property alias text: txt.text
    property alias font: txt.font

    function popup(keybutton, inputPanel) {
        width = keybutton.width * 1.4;
        height = keybutton.height * 1.4;
        var KeyButtonGlobalLeft = keybutton.mapToItem(inputPanel, 0, 0).x;
        var KeyButtonGlobalTop = keybutton.mapToItem(inputPanel, 0, 0).y;
        var PopupGlobalLeft = KeyButtonGlobalLeft - (width - keybutton.width) / 2;
        var PopupGlobalTop = KeyButtonGlobalTop - height - keyboardRect.height / 40 * 1.5;
        var PopupLeft = root.parent.mapFromItem(inputPanel, PopupGlobalLeft, PopupGlobalTop).x;
        y = root.parent.mapFromItem(inputPanel, PopupGlobalLeft, PopupGlobalTop).y;
        if (PopupGlobalLeft < 0)
            x = 0;
        else if ((PopupGlobalLeft + width) > inputPanel.width)
            x = PopupLeft - (PopupGlobalLeft + width - inputPanel.width);
        else
            x = PopupLeft;
        text = InputEngine.uppercase ? keybutton.btnText.toUpperCase() : keybutton.btnText;
        font.family = keybutton.font.family;
        visible = Qt.binding(function() {
            return keybutton.pressed;
        });
    }

    width: 40
    height: 40
    visible: false

    Rectangle {
        id: popup

        anchors.fill: parent
        radius: 6
        z: shadow.z + 1

        Text {
            id: txt

            anchors.fill: parent
            fontSizeMode: Text.Fit
            font.pixelSize: height * 0.3
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        gradient: Gradient {
            GradientStop {
                position: 0
                color: Qt.lighter(popupColor)
            }

            GradientStop {
                position: 1
                color: popupColor
            }

        }

    }

    Rectangle {
        id: shadow

        width: popup.width
        height: popup.height
        radius: popup.radius
        color: "#3F000000"
        x: 1
        y: 1
    }

}
