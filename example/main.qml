import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.CuteKeyboard 1.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: window
    visible: true
    width: 640
    height: 640
    title: qsTr("QtCuteKeyboard Example")

    ColumnLayout {
        spacing: 20
        anchors.centerIn: parent

        RowLayout {
            spacing: 10
            Text {
                id: t1
                text: qsTr("Basic TextField")
            }
            TextField {
                id: tf1
                width: 200
                height: 50
            }
        }
        RowLayout {
            spacing: 10
            Text {
                id: t2
                text: qsTr("Disabled enter key - TextField")
            }
            TextField {
                id: tf2
                width: 200
                height: 50
                EnterKeyAction.enabled: false
            }
        }
        RowLayout {
            spacing: 10
            Text {
                id: t3
                text: qsTr("Enabled enter key - TextField")
            }
            TextField {
                id: tf3
                width: 200
                height: 50
                EnterKeyAction.enabled: true
            }
        }
        RowLayout {
            spacing: 10
            Text {
                id: t4
                text: qsTr("Qt.ImhDigitsOnly TextField")
            }
            TextField {
                id: tf4
                width: 200
                height: 50
                inputMethodHints: Qt.ImhDigitsOnly
            }
        }
    }

    InputPanel {
        id: inputPanel

        z: 99
        y: window.height

        anchors.left: parent.left
        anchors.right: parent.right

        languageLayout: "It"

        states: State {
            name: "visible"
            when: Qt.inputMethod.visible
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
