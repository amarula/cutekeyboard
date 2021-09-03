TEMPLATE = subdirs

SUBDIRS = QtFreeVirtualKeyboard

contains(CONFIG, build_example) {
    SUBDIRS += example
    example.depends += QtFreeVirtualKeyboard
}
