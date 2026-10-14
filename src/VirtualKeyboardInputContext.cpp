#include "VirtualKeyboardInputContext.h"

#include <private/qquickflickable_p.h>

#include <QPropertyAnimation>
#include <QtQuick/qquickitem.h>

#include "DeclarativeInputEngine.h"
#include "EnterKeyAction.hpp"
#include "EnterKeyActionAttachedType.hpp"
#include "InputPanelIface.hpp"
#include "PanelElevator.h"
#include <QPointer>
#include <QQmlEngine>

static QObject *keepCppOwned(QObject *object) {
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QQmlEngine::setObjectOwnership(object, QQmlEngine::CppOwnership);
#else
    QJSEngine::setObjectOwnership(object, QJSEngine::CppOwnership);
#endif
    return object;
}

/**
 * Private data class for VirtualKeyboardInputContext
 */
class VirtualKeyboardInputContextPrivate {
   public:
    VirtualKeyboardInputContextPrivate();

    QPointer<QQuickFlickable> Flickable;
    QPointer<QQuickItem> FocusItem;
    bool Visible;
    DeclarativeInputEngine *InputEngine;
    QPropertyAnimation *FlickableContentScrollAnimation{nullptr};
    PanelElevator Elevator;

    InputPanelIface *inputPanelIface;
};

VirtualKeyboardInputContextPrivate::VirtualKeyboardInputContextPrivate()
    : Visible(false),
      InputEngine(new DeclarativeInputEngine()),
      inputPanelIface(new InputPanelIface()) {}

VirtualKeyboardInputContext::VirtualKeyboardInputContext()
    : QPlatformInputContext(), d(new VirtualKeyboardInputContextPrivate) {
    d->FlickableContentScrollAnimation = new QPropertyAnimation(this);
    d->FlickableContentScrollAnimation->setPropertyName("contentY");
    d->FlickableContentScrollAnimation->setDuration(400);
    d->FlickableContentScrollAnimation->setEasingCurve(
        QEasingCurve(QEasingCurve::OutBack));
    qmlRegisterSingletonType<DeclarativeInputEngine>(
        "CuteKeyboard", 1, 0, "InputEngine", inputEngineProvider);
    connect(d->InputEngine, &DeclarativeInputEngine::animatingChanged, this,
            &VirtualKeyboardInputContext::ensureFocusedObjectVisible);
    connect(d->InputEngine, &DeclarativeInputEngine::keyboardRectangleChanged, this, &VirtualKeyboardInputContext::emitKeyboardRectChanged);

    qmlRegisterSingletonType<InputPanelIface>("CuteKeyboard", 1, 0,
                                              "InputPanel", inputPanelProvider);
    qmlRegisterSingletonType<VirtualKeyboardInputContext>(
        "CuteKeyboard", 1, 0, "InputContext", inputContextProvider);
    qmlRegisterType<EnterKeyAction>("QtQuick.CuteKeyboard", 1, 0,
                                    "EnterKeyAction");
    qmlRegisterType<EnterKeyAction>("CuteKeyboard", 1, 0, "EnterKeyAction");
}

VirtualKeyboardInputContext::~VirtualKeyboardInputContext() {}

VirtualKeyboardInputContext *VirtualKeyboardInputContext::instance() {
    static VirtualKeyboardInputContext *InputContextInstance =
        new VirtualKeyboardInputContext;
    return InputContextInstance;
}

QObject *VirtualKeyboardInputContext::inputItem() const { return d->FocusItem; }

void VirtualKeyboardInputContext::setFocusItem(QQuickItem *item) {
    if (d->FocusItem == item) {
        return;
    }
    d->FocusItem = item;
    emit inputItemChanged();
}

bool VirtualKeyboardInputContext::focusItemHasEnterKeyAction(
    QObject *item) const {
    return item != nullptr &&
           qmlAttachedPropertiesObject<EnterKeyAction>(item, false);
}

bool VirtualKeyboardInputContext::isValid() const { return true; }

QRectF VirtualKeyboardInputContext::keyboardRect() const
{
    return d->InputEngine->keyboardRectangle();
}

void VirtualKeyboardInputContext::showInputPanel() {
    d->Visible = true;
    QPlatformInputContext::showInputPanel();
    emitInputPanelVisibleChanged();
}

void VirtualKeyboardInputContext::hideInputPanel() {
    if (d->FocusItem && d->FocusItem->inputMethodQuery(Qt::ImEnabled).toBool()) {
        // if the current focus item accepts input, clear its focus to ensure visual consistency
        d->FocusItem->setFocus(false);
    }
    d->Visible = false;
    QPlatformInputContext::hideInputPanel();
    emitInputPanelVisibleChanged();
}

void VirtualKeyboardInputContext::registerInputPanel(QQuickItem *panel) {
    if (!panel) return;
    if (!d->Elevator.setPanel(panel)) {
        qWarning("cutekeyboard: only one InputPanel per application is "
                 "supported, the additional InputPanel %p is used for popups "
                 "only once the current one is destroyed",
                 static_cast<void *>(panel));
        return;
    }
    d->Elevator.follow(d->FocusItem);
}

bool VirtualKeyboardInputContext::isInputPanelVisible() const {
    return d->Visible;
}

bool VirtualKeyboardInputContext::isAnimating() const { return false; }

void VirtualKeyboardInputContext::setFocusObject(QObject *object) {
    static const int NumericInputHints = Qt::ImhPreferNumbers | Qt::ImhDate |
                                         Qt::ImhTime |
                                         Qt::ImhFormattedNumbersOnly;

    QObject::disconnect(visibleConnection);
    QObject::disconnect(destroyedConnection);
    d->Flickable = nullptr;

    QQuickItem *newFocusItem = dynamic_cast<QQuickItem *>(object);
    if (!newFocusItem ||
        !newFocusItem->inputMethodQuery(Qt::ImEnabled).toBool()) {
        setFocusItem(nullptr);
        d->Elevator.follow(nullptr);
        hideInputPanel();
        return;
    }

    d->FocusItem = newFocusItem;

    visibleConnection = QObject::connect(
        d->FocusItem.data(), &QQuickItem::visibleChanged, this, [this]() {
            if (!d->FocusItem) {
                return;
            }
            if (!d->FocusItem->isVisible())
                hideInputPanel();
            else
                showInputPanel();
        });

    destroyedConnection = QObject::connect(
        d->FocusItem.data(), &QObject::destroyed, this, [this]() {
            d->FocusItem = nullptr;
            d->Flickable = nullptr;
            d->Elevator.follow(nullptr);
            emit inputItemChanged();
            hideInputPanel();
        });
    d->Elevator.follow(d->FocusItem);

    emit inputItemChanged();

    Qt::InputMethodHints InputMethodHints(
        d->FocusItem->inputMethodQuery(Qt::ImHints).toInt());
    if (InputMethodHints & Qt::ImhDigitsOnly) {
        d->InputEngine->setInputMode(DeclarativeInputEngine::DigitsOnly);
        d->InputEngine->setSymbolMode(false);
        d->InputEngine->setUppercase(false);
    } else if (InputMethodHints & NumericInputHints) {
        d->InputEngine->setInputMode(DeclarativeInputEngine::Letters);
        d->InputEngine->setSymbolMode(true);
        d->InputEngine->setUppercase(false);
    } else {
        d->InputEngine->setInputMode(DeclarativeInputEngine::Letters);
        d->InputEngine->setSymbolMode(false);
        bool shouldUppercase = d->InputEngine->isAutoCapitalize() &&
                               fieldSupportsAutoCapitalize() &&
                               surroundingText().isEmpty();
        d->InputEngine->setUppercase(shouldUppercase);
    }

    QQuickItem *i = d->FocusItem;
    while (i) {
        QQuickFlickable *Flickable = dynamic_cast<QQuickFlickable *>(i);
        if (Flickable) {
            d->Flickable = Flickable;
        }
        i = i->parentItem();
    }

    ensureFocusedObjectVisible();
}

QString VirtualKeyboardInputContext::surroundingText() const {
    if (!d->FocusItem)
        return QString();
    return d->FocusItem->inputMethodQuery(Qt::ImSurroundingText).toString();
}

bool VirtualKeyboardInputContext::fieldSupportsAutoCapitalize() const {
    if (!d->FocusItem)
        return false;
    Qt::InputMethodHints hints(d->FocusItem->inputMethodQuery(Qt::ImHints).toInt());
    return !((hints & Qt::ImhNoAutoUppercase) || (hints & Qt::ImhHiddenText) || (hints & Qt::ImhSensitiveData));
}

void VirtualKeyboardInputContext::ensureFocusedObjectVisible() {
    if (!d->Visible || !d->Flickable || !d->FocusItem ||
        d->InputEngine->isAnimating()) {
        return;
    }

    QRectF FocusItemRect(0, 0, d->FocusItem->width(), d->FocusItem->height());
    FocusItemRect = d->Flickable->mapRectFromItem(d->FocusItem, FocusItemRect);
    d->FlickableContentScrollAnimation->setTargetObject(d->Flickable);
    if (FocusItemRect.bottom() >= d->Flickable->height()) {
        auto ContentY = d->Flickable->contentY() +
                        (FocusItemRect.bottom() - d->Flickable->height()) + 20;
        d->FlickableContentScrollAnimation->setEndValue(ContentY);
        d->FlickableContentScrollAnimation->start();
    } else if (FocusItemRect.top() < 0) {
        auto ContentY = d->Flickable->contentY() + FocusItemRect.top() - 20;
        d->FlickableContentScrollAnimation->setEndValue(ContentY);
        d->FlickableContentScrollAnimation->start();
    }
}

QObject *VirtualKeyboardInputContext::inputEngineProvider(
    QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return keepCppOwned(VirtualKeyboardInputContext::instance()->d->InputEngine);
}

QObject *VirtualKeyboardInputContext::inputPanelProvider(
    QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return keepCppOwned(
        VirtualKeyboardInputContext::instance()->d->inputPanelIface);
}

QObject *VirtualKeyboardInputContext::inputContextProvider(
    QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return keepCppOwned(VirtualKeyboardInputContext::instance());
}
