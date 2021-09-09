#include "DeclarativeInputEngine.h"

#include <QGuiApplication>
#include <QInputMethodEvent>
#include <QTimer>

/**
 * Private data class
 */
struct DeclarativeInputEnginePrivate
{
    explicit DeclarativeInputEnginePrivate(DeclarativeInputEngine *_public);

    DeclarativeInputEngine *_this;
    bool Animating;
    QTimer *AnimatingFinishedTimer{nullptr};
    int InputMode;
    QRect KeyboardRectangle;

    bool isUppercase{false};
    bool symbolMode{false};
};

DeclarativeInputEnginePrivate::DeclarativeInputEnginePrivate(DeclarativeInputEngine *_public)
    : _this(_public)
    , Animating(false)
    , InputMode(DeclarativeInputEngine::Letters)
{}

DeclarativeInputEngine::DeclarativeInputEngine(QObject *parent)
    : QObject(parent)
    , d(new DeclarativeInputEnginePrivate(this))
{
    d->AnimatingFinishedTimer = new QTimer(this);
    d->AnimatingFinishedTimer->setSingleShot(true);
    d->AnimatingFinishedTimer->setInterval(100);
    connect(d->AnimatingFinishedTimer,
            &QTimer::timeout,
            this,
            &DeclarativeInputEngine::animatingFinished);
}

DeclarativeInputEngine::~DeclarativeInputEngine()
{
    delete d;
}

bool DeclarativeInputEngine::virtualKeyClick(Qt::Key key,
                                             const QString &text,
                                             Qt::KeyboardModifiers modifiers)
{
    QKeyEvent pressEvent(QEvent::KeyPress, key, Qt::KeyboardModifiers(modifiers), text);
    QKeyEvent releaseEvent(QEvent::KeyRelease, key, Qt::KeyboardModifiers(modifiers), text);
    return QCoreApplication::sendEvent(QGuiApplication::focusObject(), &pressEvent)
           && QCoreApplication::sendEvent(QGuiApplication::focusObject(), &releaseEvent);
}

QRect DeclarativeInputEngine::keyboardRectangle() const
{
    return d->KeyboardRectangle;
}

void DeclarativeInputEngine::setKeyboardRectangle(const QRect &Rect)
{
    setAnimating(true);
    d->AnimatingFinishedTimer->start(100);
    d->KeyboardRectangle = Rect;
    emit keyboardRectangleChanged();
}

bool DeclarativeInputEngine::isAnimating() const
{
    return d->Animating;
}

void DeclarativeInputEngine::setAnimating(bool Animating)
{
    if (d->Animating != Animating) {
        d->Animating = Animating;
        emit animatingChanged();
    }
}

void DeclarativeInputEngine::animatingFinished()
{
    setAnimating(false);
}

int DeclarativeInputEngine::inputMode() const
{
    return d->InputMode;
}

void DeclarativeInputEngine::setInputMode(int Mode)
{
    if (Mode != d->InputMode) {
        d->InputMode = Mode;
        emit inputModeChanged();
    }
}

bool DeclarativeInputEngine::isUppercase() const
{
    return d->isUppercase;
}

void DeclarativeInputEngine::setUppercase(bool uppercase)
{
    if (d->isUppercase != uppercase) {
        d->isUppercase = uppercase;
        emit isUppercaseChanged();
    }
}

bool DeclarativeInputEngine::isSymbolMode() const
{
    return d->symbolMode;
}

void DeclarativeInputEngine::setSymbolMode(bool symbolMode)
{
    if (d->symbolMode != symbolMode) {
        d->symbolMode = symbolMode;
        emit isSymbolModeChanged();
    }
}
