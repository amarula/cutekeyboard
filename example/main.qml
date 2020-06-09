import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.FreeVirtualKeyboard 1.0
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("QtFreeVirtualKeyboard Example")

    TextField {
        anchors.centerIn: parent
        width: 200
        height: 50
        focus: true
    }

    InputPanel {
        id: inputPanel

        z: 99
        y: window.height

        anchors.left: parent.left
        anchors.right: parent.right

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
