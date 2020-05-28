import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property color popupColor
    property alias popupTextColor: txt.color
    property alias popupTextFont: txt.font.family
    property alias text: txt.text
    property alias font: txt.font

    width: 40
    height: 40
    visible: false

    Rectangle {
        id: popup

        anchors.fill: parent
        radius: Math.round(height / 30)
        z: shadow.z + 1

        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Qt.lighter(popupColor)
            }
            GradientStop {
                position: 1.0
                color: popupColor
            }
        }

        Text {
            id: txt

            anchors.fill: parent
            fontSizeMode: Text.Fit
            font.pixelSize: height * 0.7
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: shadow

        width: popup.width
        height: popup.height
        radius: popup.radius
        color: "#3F000000"
        x: 4
        y: 4
    }

    function popup(keybutton, inputPanel) {
        width = keybutton.width * 1.4
        height = keybutton.height * 1.4
        var KeyButtonGlobalLeft = keybutton.mapToItem(inputPanel, 0, 0).x
        var KeyButtonGlobalTop = keybutton.mapToItem(inputPanel, 0, 0).y
        var PopupGlobalLeft = KeyButtonGlobalLeft - (width - keybutton.width) / 2
        var PopupGlobalTop = KeyButtonGlobalTop - height - pimpl.verticalSpacing * 1.5
        var PopupLeft = root.parent.mapFromItem(inputPanel, PopupGlobalLeft,
                                                PopupGlobalTop).x
        y = root.parent.mapFromItem(inputPanel, PopupGlobalLeft,
                                    PopupGlobalTop).y

        if (PopupGlobalLeft < 0) {
            x = 0
        } else if ((PopupGlobalLeft + width) > inputPanel.width) {
            x = PopupLeft - (PopupGlobalLeft + width - inputPanel.width)
        } else {
            x = PopupLeft
        }

        text = keybutton.displayedText
        font.family = keybutton.font.family
        visible = Qt.binding(function () {
            return keybutton.pressed
        })
    }
}
