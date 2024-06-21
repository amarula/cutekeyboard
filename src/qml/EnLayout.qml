import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    property var inputPanel

    RowLayout {
        property real keyWeight: 160

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
            alternativeKeys: "êëèé"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_R
            btnText: "r"
            alternativeKeys: "ŕř"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_T
            btnText: "t"
            alternativeKeys: "ţŧť"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_Y
            btnText: "y"
            alternativeKeys: "ÿýŷ"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_U
            btnText: "u"
            alternativeKeys: "űūũûüùú"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_I
            btnText: "i"
            alternativeKeys: "îïīĩìí"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_O
            btnText: "o"
            alternativeKeys: "œøõôöòó"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_P
            btnText: "p"
            inputPanelRef: inputPanel
        }

        BackspaceKey {
            inputPanelRef: inputPanel
        }

    }

    RowLayout {
        property real keyWeight: 160

        Key {
            weight: 56
            functionKey: true
            showPreview: false
            btnBackground: "transparent"
        }

        Key {
            btnKey: Qt.Key_A
            btnText: "a"
            alternativeKeys: "äåãâàá"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_S
            btnText: "s"
            alternativeKeys: "šşś"
            inputPanelRef: inputPanel
        }

        Key {
            btnKey: Qt.Key_D
            btnText: "d"
            alternativeKeys: "đď"
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
            alternativeKeys: "ġģĝğ"
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
            alternativeKeys: "ĺŀłļľ"
            inputPanelRef: inputPanel
        }

        EnterKey {
            weight: 283
            inputPanelRef: inputPanel
        }

    }

    RowLayout {
        property real keyWeight: 156

        ShiftKey {
        }

        Key {
            btnKey: Qt.Key_Z
            btnText: "z"
            alternativeKeys: "žż"
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
            alternativeKeys: "çċčć"
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
            alternativeKeys: "ņńň"
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

        ShiftKey {
            weight: 204
        }

    }

    RowLayout {
        property real keyWeight: 154

        SymbolKey {
            weight: availableLanguageLayouts.length === 1 ? 217 : 108.5
        }

        LanguageKey {
            visible: availableLanguageLayouts.length > 1
            weight: 108.5
        }

        SpaceKey {
            weight: 1168
            inputPanelRef: inputPanel
            btnDisplayedText: langDescription
        }

        Key {
            btnKey: Qt.Key_Apostrophe
            btnText: "'"
            inputPanelRef: inputPanel
        }

        HideKey {
            weight: 205
        }

    }

}
