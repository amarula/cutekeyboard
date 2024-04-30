[![Build](https://github.com/amarula/cutekeyboard/actions/workflows/build.yml/badge.svg)](https://github.com/amarula/cutekeyboard/actions/workflows/build.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# CuteKeyboard

CuteKeyboard is a Qt virtual keyboard plugin for embedded applications.

## Installation

Download the repository, build and install the plugin.

```bash
mkdir build && cd build
qmake ..
make -j4
make install
```

### Custom Installation

```bash
mkdir build && cd build
qmake .. INSTALL_PREFIX=/home/custom_dir/custom_root
make -j4
make install
```

## Examples

```bash
mkdir build && cd build
qmake .. CONFIG+=BUILD_EXAMPLES
make -j4
make install
```

## Usage

In the `main.cpp` add the `cutekeyboard` plugin.

```c++
qputenv("QT_IM_MODULE", QByteArray("cutekeyboard"));
```

In the `main.qml` insert the keyboard component

```javascript
import QtQuick.CuteKeyboard 1.0

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
