#include "InputPanelIface.hpp"

struct InputPanelIface::InputPanelIfacePrivate {
    QColor backgroundColor{};
    QColor btnBackgroundColor{};
    QColor btnSpecialBackgroundColor{};
    QColor btnTextColor{};
    QString btnTextFontFamily{};
    QString backspaceIcon{};
    QString enterIcon{};
    QString shiftOnIcon{};
    QString shiftOffIcon{};
    QString hideKeyboardIcon{};
    QString languageIcon{};
    QStringList availableLanguageLayouts{};
    QString languageLayout{};
};

InputPanelIface::InputPanelIface(QObject *parent)
    : QObject(parent), pimpl(new InputPanelIfacePrivate) {}

InputPanelIface::~InputPanelIface() {
    if (pimpl != nullptr) {
        delete pimpl;
    }
}

QColor InputPanelIface::backgroundColor() const {
    return pimpl->backgroundColor;
}

void InputPanelIface::setBackgroundColor(const QColor &backgroundColor) {
    if (pimpl->backgroundColor != backgroundColor) {
        pimpl->backgroundColor = backgroundColor;
        emit backgroundColorChanged();
    }
}

QColor InputPanelIface::btnBackgroundColor() const {
    return pimpl->btnBackgroundColor;
}

void InputPanelIface::setBtnBackgroundColor(const QColor &btnBackgroundColor) {
    if (pimpl->btnBackgroundColor != btnBackgroundColor) {
        pimpl->btnBackgroundColor = btnBackgroundColor;
        emit btnBackgroundColorChanged();
    }
}

QColor InputPanelIface::btnSpecialBackgroundColor() const {
    return pimpl->btnSpecialBackgroundColor;
}

void InputPanelIface::setBtnSpecialBackgroundColor(
    const QColor &btnSpecialBackgroundColor) {
    if (pimpl->btnSpecialBackgroundColor != btnSpecialBackgroundColor) {
        pimpl->btnSpecialBackgroundColor = btnSpecialBackgroundColor;
        emit btnSpecialBackgroundColorChanged();
    }
}

QColor InputPanelIface::btnTextColor() const { return pimpl->btnTextColor; }

void InputPanelIface::setBtnTextColor(const QColor &btnTextColor) {
    if (pimpl->btnTextColor != btnTextColor) {
        pimpl->btnTextColor = btnTextColor;
        emit btnTextColorChanged();
    }
}

QString InputPanelIface::btnTextFontFamily() const {
    return pimpl->btnTextFontFamily;
}

void InputPanelIface::setBtnTextFontFamily(const QString &btnTextFontFamily) {
    if (pimpl->btnTextFontFamily != btnTextFontFamily) {
        pimpl->btnTextFontFamily = btnTextFontFamily;
        emit btnTextFontFamilyChanged();
    }
}

QString InputPanelIface::backspaceIcon() const { return pimpl->backspaceIcon; }

void InputPanelIface::setBackspaceIcon(const QString &backspaceIcon) {
    if (pimpl->backspaceIcon != backspaceIcon) {
        pimpl->backspaceIcon = backspaceIcon;
        emit backspaceIconChanged();
    }
}

QString InputPanelIface::enterIcon() const { return pimpl->enterIcon; }

void InputPanelIface::setEnterIcon(const QString &enterIcon) {
    if (pimpl->enterIcon != enterIcon) {
        pimpl->enterIcon = enterIcon;
        emit enterIconChanged();
    }
}

QString InputPanelIface::shiftOnIcon() const { return pimpl->shiftOnIcon; }

void InputPanelIface::setShiftOnIcon(const QString &shiftOnIcon) {
    if (pimpl->shiftOnIcon != shiftOnIcon) {
        pimpl->shiftOnIcon = shiftOnIcon;
        emit shiftOnIconChanged();
    }
}

QString InputPanelIface::shiftOffIcon() const { return pimpl->shiftOffIcon; }

void InputPanelIface::setShiftOffIcon(const QString &shiftOffIcon) {
    if (pimpl->shiftOffIcon != shiftOffIcon) {
        pimpl->shiftOffIcon = shiftOffIcon;
        emit shiftOffIconChanged();
    }
}

QString InputPanelIface::hideKeyboardIcon() const {
    return pimpl->hideKeyboardIcon;
}

void InputPanelIface::setHideKeyboardIcon(const QString &hideKeyboardIcon) {
    if (pimpl->hideKeyboardIcon != hideKeyboardIcon) {
        pimpl->hideKeyboardIcon = hideKeyboardIcon;
        emit hideKeyboardIconChanged();
    }
}

QString InputPanelIface::languageIcon() const { return pimpl->languageIcon; }

void InputPanelIface::setLanguageIcon(const QString &languageIcon) {
    if (pimpl->languageIcon != languageIcon) {
        pimpl->languageIcon = languageIcon;
        emit languageIconChanged();
    }
}

QStringList InputPanelIface::availableLanguageLayouts() const {
    return pimpl->availableLanguageLayouts;
}

void InputPanelIface::setAvailableLanguageLayouts(
    const QStringList &availableLanguageLayouts) {
    if (pimpl->availableLanguageLayouts != availableLanguageLayouts) {
        pimpl->availableLanguageLayouts = availableLanguageLayouts;
        emit availableLanguageLayoutsChanged();
    }
}

QString InputPanelIface::languageLayout() const {
    return pimpl->languageLayout;
}

void InputPanelIface::setLanguageLayout(const QString &languageLayout) {
    if (pimpl->languageLayout != languageLayout) {
        pimpl->languageLayout = languageLayout;
        emit languageLayoutChanged();
    }
}
