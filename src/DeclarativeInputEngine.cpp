#include "DeclarativeInputEngine.h"

#include <QDebug>
#include <QGuiApplication>
#include <QInputMethodEvent>
#include <QMetaEnum>
#include <QTimer>

#include "DeclarativeInputEngine.h"

/**
 * Private data class
 */
struct DeclarativeInputEnginePrivate {
    explicit DeclarativeInputEnginePrivate(DeclarativeInputEngine *_public);

    struct LayoutData {
        QString layoutFile;
        QString description;
        QString spaceIdentifier = "Space";
    };

    DeclarativeInputEngine *_this;
    bool Animating;
    QTimer *AnimatingFinishedTimer{nullptr};
    int InputMode;
    QRect KeyboardRectangle;

    bool isUppercase{false};
    bool symbolMode{false};
    QHash<DeclarativeInputEngine::InputLayouts, LayoutData> layoutFiles = {
        {DeclarativeInputEngine::En, {"EnLayout", "English"}},
        {DeclarativeInputEngine::Fr, {"FrLayout", "Français"}},
        {DeclarativeInputEngine::It, {"ItLayout", "Italiano"}},
        {DeclarativeInputEngine::Es, {"EsLayout", "Español"}},
        {DeclarativeInputEngine::De, {"DeLayout", "Deutsch", "Leerzeichen"}},
        {DeclarativeInputEngine::Nl, {"NlLayout", "Nederlands"}},
        {DeclarativeInputEngine::Pt, {"PtLayout", "Português"}},
        {DeclarativeInputEngine::Cs, {"CsLayout", "Čeština"}},
        {DeclarativeInputEngine::El, {"ElLayout", "Ελληνικός"}},
        {DeclarativeInputEngine::Pl, {"PlLayout", "Polski"}},
        {DeclarativeInputEngine::Hr, {"LtSrHrBsLayout", "Hrvatski"}},
        {DeclarativeInputEngine::CyBs, {"CySrBsLayout", "Босански"}},
        {DeclarativeInputEngine::LtBs, {"LtSrHrBsLayout", "Bosanski"}},
        {DeclarativeInputEngine::CySr, {"CySrBsLayout", "Српски"}},
        {DeclarativeInputEngine::LtSr, {"LtSrHrBsLayout", "Srpski"}},
        {DeclarativeInputEngine::Sv, {"SvLayout", "Svenska"}},
        {DeclarativeInputEngine::Ru, {"RuLayout", "Русский", "Пробел"}},
        {DeclarativeInputEngine::Uk, {"UkLayout", "Українська", "Пробіл"}},
    };
};

DeclarativeInputEnginePrivate::DeclarativeInputEnginePrivate(
    DeclarativeInputEngine *_public)
    : _this(_public),
      Animating(false),
      InputMode(DeclarativeInputEngine::Letters) {}

DeclarativeInputEngine::DeclarativeInputEngine(QObject *parent)
    : QObject(parent), d(new DeclarativeInputEnginePrivate(this)) {
    d->AnimatingFinishedTimer = new QTimer(this);
    d->AnimatingFinishedTimer->setSingleShot(true);
    d->AnimatingFinishedTimer->setInterval(100);
    connect(d->AnimatingFinishedTimer, &QTimer::timeout, this,
            &DeclarativeInputEngine::animatingFinished);
}

DeclarativeInputEngine::~DeclarativeInputEngine() { delete d; }

bool DeclarativeInputEngine::virtualKeyClick(Qt::Key key, const QString &text,
                                             Qt::KeyboardModifiers modifiers) {
    QKeyEvent pressEvent(QEvent::KeyPress, key,
                         Qt::KeyboardModifiers(modifiers), text);
    QKeyEvent releaseEvent(QEvent::KeyRelease, key,
                           Qt::KeyboardModifiers(modifiers), text);
    return QCoreApplication::sendEvent(QGuiApplication::focusObject(),
                                       &pressEvent) &&
           QCoreApplication::sendEvent(QGuiApplication::focusObject(),
                                       &releaseEvent);
}

QRect DeclarativeInputEngine::keyboardRectangle() const {
    return d->KeyboardRectangle;
}

void DeclarativeInputEngine::setKeyboardRectangle(const QRect &Rect) {
    setAnimating(true);
    d->AnimatingFinishedTimer->start(100);
    d->KeyboardRectangle = Rect;
    emit keyboardRectangleChanged();
}

bool DeclarativeInputEngine::isAnimating() const { return d->Animating; }

void DeclarativeInputEngine::setAnimating(bool Animating) {
    if (d->Animating != Animating) {
        d->Animating = Animating;
        emit animatingChanged();
    }
}

void DeclarativeInputEngine::animatingFinished() { setAnimating(false); }

int DeclarativeInputEngine::inputMode() const { return d->InputMode; }

void DeclarativeInputEngine::setInputMode(int Mode) {
    if (Mode != d->InputMode) {
        d->InputMode = Mode;
        emit inputModeChanged();
    }
}

bool DeclarativeInputEngine::isUppercase() const { return d->isUppercase; }

void DeclarativeInputEngine::setUppercase(bool uppercase) {
    if (d->isUppercase != uppercase) {
        d->isUppercase = uppercase;
        emit isUppercaseChanged();
    }
}

bool DeclarativeInputEngine::isSymbolMode() const { return d->symbolMode; }

void DeclarativeInputEngine::setSymbolMode(bool symbolMode) {
    if (d->symbolMode != symbolMode) {
        d->symbolMode = symbolMode;
        emit isSymbolModeChanged();
    }
}

bool DeclarativeInputEngine::inputLayoutValid(const QString &layout) const {
    for (int i = InputLayouts::En; i != InputLayouts::EndLayouts; i++) {
        const auto validLayout = QMetaEnum::fromType<InputLayouts>().valueToKey(
            static_cast<InputLayouts>(i));
        if (validLayout == layout) {
            return true;
        }
    }

    qCritical() << "Keyboard layout" << layout
                << "is not supported. Falling back to En!";
    return false;
}

QString DeclarativeInputEngine::fileOfLayout(QString layout) {
    if (!inputLayoutValid(layout)) {
        return "";
    }
    bool ok = false;
    auto layoutVal = static_cast<InputLayouts>(
        QMetaEnum::fromType<InputLayouts>().keyToValue(layout.toUtf8().data(),
                                                       &ok));
    if (!ok) {
        return "";
    }
    return d->layoutFiles.value(layoutVal, {}).layoutFile;
}

QString DeclarativeInputEngine::descriptionOfLayout(QString layout) {
    if (!inputLayoutValid(layout)) {
        return "";
    }
    bool ok = false;
    auto layoutVal = static_cast<InputLayouts>(
        QMetaEnum::fromType<InputLayouts>().keyToValue(layout.toUtf8().data(),
                                                       &ok));
    if (!ok) {
        return "";
    }
    return d->layoutFiles.value(layoutVal, {}).description;
}

QString DeclarativeInputEngine::spaceIdentifierOfLayout(QString layout)
{
    if (!inputLayoutValid(layout)) {
        return "";
    }
    bool ok = false;
    auto layoutVal = static_cast<InputLayouts>(
        QMetaEnum::fromType<InputLayouts>().keyToValue(layout.toUtf8().data(),
                                                       &ok));
    if (!ok) {
        return "";
    }
    return d->layoutFiles.value(layoutVal, {}).spaceIdentifier;
}
