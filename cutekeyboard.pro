TEMPLATE = subdirs

SUBDIRS = src

contains(CONFIG, BUILD_EXAMPLES) {
    SUBDIRS += example
    example.depends += src
}
