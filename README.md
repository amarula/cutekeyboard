[![Build](https://github.com/amarula/cutekeyboard/actions/workflows/build.yml/badge.svg)](https://github.com/amarula/cutekeyboard/actions/workflows/build.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# CuteKeyboard

**[🌐 Website →](https://amarula.github.io/cutekeyboard/)**

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

### Popups and dialogs

Text fields inside Qt Quick Controls 2 `Popup`, `Dialog` and other
items hosted by the window overlay work without any changes to the application.
While such a field has the focus, the keyboard is shown above the overlay, so
it is drawn over the popup and its dimming layer and receives taps even when
the popup is modal. Tapping keys does not count as a press outside the popup.
When the focus leaves the overlay, the `InputPanel` returns to the parent and
stacking position it was given in QML.

While it is above the overlay, the `InputPanel` is placed in a helper item
that copies the geometry of its original parent. Bindings to `parent`, such as
`anchors.left: parent.left` or `width: parent.width`, keep working; anchors to
sibling items do not apply during that time. A panel placed by a layout or
positioner (`ColumnLayout`, `Column`) leaves it while above the overlay and
keeps its last geometry, and its siblings are laid out again behind the popup.

Notes:

* Only one `InputPanel` per application is supported. Any further one is
  reported with a warning and is used for popups only once the first one is
  destroyed.
* Versions 1.3.0 to 1.7.0 gave the `InputPanel` the highest `z` and, when it
  was not a direct child of the window, moved it to the window root item on
  focus. It now keeps the parent and `z` given in QML, so place it above the
  rest of the content yourself, for example as a direct child of the window
  with a high `z` as shown above.
* Native dialogs from `QtQuick.Dialogs` open separate system windows and are
  not supported.

## Authors
 * **Uwe Kindler** - *Initial work* - [githubuser0xFFFF](https://github.com/githubuser0xFFFF)
 * **Andrea Ricchi** - *Maintainer* - [AndreaRicchi](https://github.com/AndreaRicchi)
