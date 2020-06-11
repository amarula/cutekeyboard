#include "VirtualKeyboardInputContext.h"

#include "DeclarativeInputEngine.h"

#include <private/qquickflickable_p.h>

#include <QPropertyAnimation>

/**
 * Private data class for VirtualKeyboardInputContext
 */
class VirtualKeyboardInputContextPrivate
{
public:
    VirtualKeyboardInputContextPrivate();

    QQuickFlickable *Flickable;
    QQuickItem *FocusItem;
    bool Visible;
    DeclarativeInputEngine *InputEngine;
    QPropertyAnimation *FlickableContentScrollAnimation{nullptr};
};

VirtualKeyboardInputContextPrivate::VirtualKeyboardInputContextPrivate()
    : Flickable(0)
    , FocusItem(0)
    , Visible(false)
    , InputEngine(new DeclarativeInputEngine())
{}

VirtualKeyboardInputContext::VirtualKeyboardInputContext()
    : QPlatformInputContext()
    , d(new VirtualKeyboardInputContextPrivate)
{
    d->FlickableContentScrollAnimation = new QPropertyAnimation(this);
    d->FlickableContentScrollAnimation->setPropertyName("contentY");
    d->FlickableContentScrollAnimation->setDuration(400);
    d->FlickableContentScrollAnimation->setEasingCurve(QEasingCurve(QEasingCurve::OutBack));
    qmlRegisterSingletonType<DeclarativeInputEngine>("FreeVirtualKeyboard",
                                                     1,
                                                     0,
                                                     "InputEngine",
                                                     inputEngineProvider);
    connect(d->InputEngine,
            &DeclarativeInputEngine::animatingChanged,
            this,
            &VirtualKeyboardInputContext::ensureFocusedObjectVisible);
}

VirtualKeyboardInputContext::~VirtualKeyboardInputContext() {}

VirtualKeyboardInputContext *VirtualKeyboardInputContext::instance()
{
    static VirtualKeyboardInputContext *InputContextInstance = new VirtualKeyboardInputContext;
    return InputContextInstance;
}

bool VirtualKeyboardInputContext::isValid() const
{
    return true;
}

QRectF VirtualKeyboardInputContext::keyboardRect() const
{
    return QRectF();
}

void VirtualKeyboardInputContext::showInputPanel()
{
    d->Visible = true;
    QPlatformInputContext::showInputPanel();
    emitInputPanelVisibleChanged();
}

void VirtualKeyboardInputContext::hideInputPanel()
{
    d->Visible = false;
    QPlatformInputContext::hideInputPanel();
    emitInputPanelVisibleChanged();
}

bool VirtualKeyboardInputContext::isInputPanelVisible() const
{
    return d->Visible;
}

bool VirtualKeyboardInputContext::isAnimating() const
{
    return false;
}

void VirtualKeyboardInputContext::setFocusObject(QObject *object)
{
    static const int NumericInputHints = Qt::ImhPreferNumbers | Qt::ImhDate | Qt::ImhTime
                                         | Qt::ImhDigitsOnly | Qt::ImhFormattedNumbersOnly;
    static const int DialableInputHints = Qt::ImhDialableCharactersOnly;

    if (!object) {
        return;
    }

    d->FocusItem = dynamic_cast<QQuickItem *>(object);
    if (!d->FocusItem) {
        return;
    }

    bool AcceptsInput = d->FocusItem->inputMethodQuery(Qt::ImEnabled).toBool();
    if (!AcceptsInput) {
        return;
    }

    Qt::InputMethodHints InputMethodHints(d->FocusItem->inputMethodQuery(Qt::ImHints).toInt());
    if (InputMethodHints & DialableInputHints) {
        d->InputEngine->setInputMode(DeclarativeInputEngine::Dialable);
    } else if (InputMethodHints & NumericInputHints) {
        d->InputEngine->setInputMode(DeclarativeInputEngine::Numeric);
    } else {
        d->InputEngine->setInputMode(DeclarativeInputEngine::Latin);
    }

    QQuickItem *i = d->FocusItem;
    d->Flickable = 0;
    while (i) {
        QQuickFlickable *Flickable = dynamic_cast<QQuickFlickable *>(i);
        if (Flickable) {
            d->Flickable = Flickable;
        }
        i = i->parentItem();
    }

    ensureFocusedObjectVisible();
}

void VirtualKeyboardInputContext::ensureFocusedObjectVisible()
{
    if (!d->Visible || !d->Flickable || d->InputEngine->isAnimating()) {
        return;
    }

    QRectF FocusItemRect(0, 0, d->FocusItem->width(), d->FocusItem->height());
    FocusItemRect = d->Flickable->mapRectFromItem(d->FocusItem, FocusItemRect);
    d->FlickableContentScrollAnimation->setTargetObject(d->Flickable);
    if (FocusItemRect.bottom() >= d->Flickable->height()) {
        auto ContentY = d->Flickable->contentY() + (FocusItemRect.bottom() - d->Flickable->height())
                        + 20;
        d->FlickableContentScrollAnimation->setEndValue(ContentY);
        d->FlickableContentScrollAnimation->start();
    } else if (FocusItemRect.top() < 0) {
        auto ContentY = d->Flickable->contentY() + FocusItemRect.top() - 20;
        d->FlickableContentScrollAnimation->setEndValue(ContentY);
        d->FlickableContentScrollAnimation->start();
    }
}

QObject *VirtualKeyboardInputContext::inputEngineProvider(QQmlEngine *engine,
                                                          QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return VirtualKeyboardInputContext::instance()->d->InputEngine;
}
