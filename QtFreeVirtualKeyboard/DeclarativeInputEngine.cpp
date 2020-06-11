#include "DeclarativeInputEngine.h"

#include <QCoreApplication>
#include <QGuiApplication>
#include <QInputMethodEvent>
#include <QJSEngine>
#include <QQmlEngine>
#include <QTimer>
#include <QtQml>

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
};

DeclarativeInputEnginePrivate::DeclarativeInputEnginePrivate(DeclarativeInputEngine *_public)
    : _this(_public)
    , Animating(false)
    , InputMode(DeclarativeInputEngine::Latin)
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

void DeclarativeInputEngine::virtualKeyCancel() {}

bool DeclarativeInputEngine::virtualKeyClick(Qt::Key key,
                                             const QString &text,
                                             Qt::KeyboardModifiers modifiers)
{
    Q_UNUSED(key)
    Q_UNUSED(modifiers)

    QInputMethodEvent ev;
    if (text == QString("\x7F")) {
        ev.setCommitString("", -1, 1);

    } else {
        ev.setCommitString(text);
    }
    QCoreApplication::sendEvent(QGuiApplication::focusObject(), &ev);
    return true;
}

void DeclarativeInputEngine::sendKeyToFocusItem(const QString &text)
{
    QInputMethodEvent ev;
    if (text == QString("\x7F")) {
        ev.setCommitString("", -1, 1);

    } else {
        ev.setCommitString(text);
    }
    QCoreApplication::sendEvent(QGuiApplication::focusObject(), &ev);
}

bool DeclarativeInputEngine::virtualKeyPress(Qt::Key key,
                                             const QString &text,
                                             Qt::KeyboardModifiers modifiers,
                                             bool repeat)
{
    Q_UNUSED(key)
    Q_UNUSED(text)
    Q_UNUSED(modifiers)
    Q_UNUSED(repeat)

    // TODO: do awsomness

    return true;
}

bool DeclarativeInputEngine::virtualKeyRelease(Qt::Key key,
                                               const QString &text,
                                               Qt::KeyboardModifiers modifiers)
{
    Q_UNUSED(key)
    Q_UNUSED(text)
    Q_UNUSED(modifiers)

    // TODO: do awsomness

    return true;
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
