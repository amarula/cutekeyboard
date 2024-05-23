import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    property var inputPanel
    spacing:0

    RowLayout {
        property real keyWeight: 140
        spacing:0

        Key {
            btnKey: Qt.Key_Q
            btnText: "q"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_W
            btnText: "w"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_E
            btnText: "e"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_R
            btnText: "r"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_T
            btnText: "t"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Z
            btnText: "z"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_U
            btnText: "u"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_I
            btnText: "i"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_O
            btnText: "o"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_P
            btnText: "p"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Udiaeresis
            btnText: "ü"
            inputPanelRef: inputPanel
        }

        BackspaceKey {
            weight: 160
            inputPanelRef: inputPanel
        }

    }

    RowLayout {
        property real keyWeight: 140
        spacing:0

        Key {
            weight: 56
            functionKey: true
            showPreview: false
            btnBackground: "transparent"
        }

        Key {
            btnKey: Qt.Key_A
            btnText: "a"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_S
            btnText: "s"
            alternativeKeys: "ß"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_D
            btnText: "d"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_F
            btnText: "f"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_G
            btnText: "g"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_H
            btnText: "h"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_J
            btnText: "j"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_K
            btnText: "k"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_L
            btnText: "l"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Odiaeresis
            btnText: "ö"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Adiaeresis
            btnText: "ä"
            inputPanelRef: inputPanel
        }

        EnterKey {
            weight: 200
            inputPanelRef: inputPanel
        }

    }

    RowLayout {
        property real keyWeight: 140
        spacing:0

        ShiftKey {
        }

        Key {
            btnKey: Qt.Key_Y
            btnText: "y"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_X
            btnText: "x"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_C
            btnText: "c"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_V
            btnText: "v"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_B
            btnText: "b"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_N
            btnText: "n"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_M
            btnText: "m"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Comma
            btnText: ","
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Period
            btnText: "."
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Minus
            btnText: "-"
            inputPanelRef: inputPanel
        }

        ShiftKey {
            weight: 200
        }

    }

    RowLayout {
        property real keyWeight: 140
        spacing:0

        SymbolKey {
            weight: 217
        }

        LanguageKey {
            visible: availableLanguageLayouts.length > 1
            weight: 140
        }

        SpaceKey {
            weight: 900
            inputPanelRef: inputPanel
            btnDisplayedText: "Deutsch"
            opacity: 0.5
        }

        Key {
            btnKey: Qt.Key_Apostrophe
            btnText: "'"
            inputPanelRef: inputPanel
        }

        HideKey {
            weight: 200
        }

    }

}
