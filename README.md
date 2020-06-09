# QtFreeVirtualKeyboard

QtFreeVirtualKeyboard is a Qt virtual keyboard plugin for embedded applications.

## Installation

Download the repository, build and install the plugin.

```bash
git clone https://github.com/amarula/QtFreeVirtualKeyboard.git
mkdir build && cd build
qmake ../VirtualKeyboard
make -j4
make install
```

## Usage

In the `main.cpp` add the `freevirtualkeyboard` plugin.

```c++
qputenv("QT_IM_MODULE", QByteArray("freevirtualkeyboard"));
```

In the `main.qml` insert the keyboard component

```javascript
import QtQuick.FreeVirtualKeyboard 1.0

...

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
```
## Authors
 * **Uwe Kindler** - *Initial work* - [githubuser0xFFFF](https://github.com/githubuser0xFFFF)
 * **Andrea Ricchi** - *Maintainer* - [AndreaRicchi](https://github.com/AndreaRicchi)

## License
[MIT](https://choosealicense.com/licenses/mit/)