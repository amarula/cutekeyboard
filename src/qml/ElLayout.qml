import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    property var inputPanel
    spacing:0

    RowLayout {
        property real keyWeight: 140
        spacing:0

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
            btnDisplayedText: "Ελληνικός"
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
