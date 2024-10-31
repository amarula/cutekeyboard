import QtQuick 2.0
import QtQuick.Layouts 1.12

ColumnLayout {
    property var inputPanel

    RowLayout {
        property real keyWeight: 160

        Key {            
            btnText: "й"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "ц"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "у"            
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "к"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "е"
            alternativeKeys: "ё"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "н"            
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "г"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ш"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "щ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "з"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "х"
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
            btnText: "ф"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ы"
            inputPanelRef: inputPanel
        }

        Key {        
            btnText: "в"            
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "а"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "п"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "р"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "о"
            inputPanelRef: inputPanel
        }

        Key {s            
            btnText: "л"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "д"        
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "ж"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "э"
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
            btnText: "я"            
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ч"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "с"            
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "м"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "и"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "т"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "ь"
            alternativeKeys: "ъ"
            inputPanelRef: inputPanel
        }

        Key {
            btnText: "б"
            inputPanelRef: inputPanel
        }

        Key {            
            btnText: "ю"
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
            btnKey: Qt.Key_Period
            btnText: "."
            alternativeKeys: ","
            inputPanelRef: inputPanel
        }

        HideKey {
            weight: 205
        }

    }

}
