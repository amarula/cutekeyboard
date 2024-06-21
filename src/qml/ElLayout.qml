import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    property var inputPanel

    RowLayout {
        property real keyWeight: 160

        Key {
            btnText: "ς"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ε"
            alternativeKeys: "έ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ρ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "τ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ψ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "υ"
            alternativeKeys: "ύϋΰ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "θ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ι"
            alternativeKeys: "ίϊΐ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ο"
            alternativeKeys: "ό"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "π"
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
            btnText: "α"
            alternativeKeys: "ά"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "σ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "δ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "φ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "γ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "η"
            alternativeKeys: "ή"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ξ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "κ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "λ"
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
            btnText: "ζ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "χ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ψ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ω"
            alternativeKeys: "ώ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "β"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ν"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "μ"
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
            alternativeKeys: "!.;?"
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
