import CuteKeyboard 1.0
import QtQuick 2.0
import QtQuick.Layouts 1.12

Item {
    id: root

    property var alternativeKeys: []

    function open(keybutton, inputPanel) {
        alternativeKeys = keybutton.alternativeKeys;
        width = keybutton.width * 1 * alternativeKeys.length;
        height = keybutton.height * 1.2;
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
        loadAlternativesKey();
        visible = true;
    }

    function loadAlternativesKey() {
        listModel.clear();
        for (var i = 0; i < alternativeKeys.length; i++) {
            listModel.append({
                "btnText": InputEngine.uppercase ? alternativeKeys[i].toUpperCase() : alternativeKeys[i]
            });
        }
    }

    visible: false

    ListModel {
        id: listModel
    }

    Rectangle {
        id: listViewBackground

        radius: Math.round(height / 20)
        color: InputPanel.backgroundColor
        anchors.fill: parent

        RowLayout {
            spacing: 1

            anchors {
                fill: parent
                margins: 1
            }

            Repeater {
                model: listModel

                Key {
                    btnText: model.btnText
                    showPreview: false
                    weight: width
                    onClicked: root.visible = false
                }

            }

        }

    }

}
