import QtQuick 2.0
import QtQuick.Layouts 1.12

import FreeVirtualKeyboard 1.0

ColumnLayout {

    property var inputPanel

    ColumnLayout {
        Layout.fillWidth: false
        Layout.fillHeight: true
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: height

        RowLayout {
            property real keyWeight
            Key {
                btnKey: Qt.Key_7
                btnText: "7"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.Key_8
                btnText: "8"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.Key_9
                btnText: "9"
                inputPanelRef: inputPanel
            }
            BackspaceKey {
                inputPanelRef: inputPanel
            }
        }
        RowLayout {
            property real keyWeight
            Key {
                btnKey: Qt.Key_4
                btnText: "4"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.Key_5
                btnText: "5"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.Key_6
                btnText: "6"
                inputPanelRef: inputPanel
            }
            Key {
                btnText: " "
                btnDisplayedText: "\u2423"
                repeatable: true
                showPreview: false
                btnKey: Qt.Key_Space
                inputPanelRef: inputPanel
            }
        }
        RowLayout {
            property real keyWeight
            Key {
                btnKey: Qt.Key_1
                btnText: "1"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.Key_2
                btnText: "2"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.Key_3
                btnText: "3"
                inputPanelRef: inputPanel
            }
            HideKey {
                inputPanelRef: inputPanel
            }
        }
        RowLayout {
            property real keyWeight
            Key {
                btnKey: Qt.Key_0
                btnText: "0"
                inputPanelRef: inputPanel
            }
            Key {
                btnKey: Qt.locale(
                            ).decimalPoint === "," ? Qt.Key_Comma : Qt.Key_Period
                btnText: Qt.locale().decimalPoint === "," ? "," : "."

                inputPanelRef: inputPanel
            }
            EnterKey {
                inputPanelRef: inputPanel
            }
        }
    }
}
