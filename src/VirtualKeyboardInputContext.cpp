#include "VirtualKeyboardInputContext.h"

#include <private/qquickflickable_p.h>

#include <QPropertyAnimation>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickwindow.h>

#include "DeclarativeInputEngine.h"
#include "EnterKeyAction.hpp"
#include "EnterKeyActionAttachedType.hpp"
#include "InputPanelIface.hpp"
#include <QQmlEngine>

/**
 * Private data class for VirtualKeyboardInputContext
 */
class VirtualKeyboardInputContextPrivate {
   public:
    VirtualKeyboardInputContextPrivate();

    QQuickFlickable *Flickable;
    QQuickItem *FocusItem;
    bool Visible;
    DeclarativeInputEngine *InputEngine;
    QPropertyAnimation *FlickableContentScrollAnimation{nullptr};

    InputPanelIface *inputPanelIface;
};

VirtualKeyboardInputContextPrivate::VirtualKeyboardInputContextPrivate()
    : Flickable(0),
      FocusItem(0),
      Visible(false),
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

bool VirtualKeyboardInputContext::focusItemHasEnterKeyAction(
    QObject *item) const {
    return item != nullptr &&
           qmlAttachedPropertiesObject<EnterKeyAction>(item, false);
}

void VirtualKeyboardInputContext::registerInputPanel(QObject *inputPanel)
{
    Q_ASSERT(!this->inputPanel);
    this->inputPanel = inputPanel;
    if (QQuickItem *item = qobject_cast<QQuickItem *>(inputPanel))
        item->setZ(std::numeric_limits<qreal>::max());
}

bool VirtualKeyboardInputContext::isValid() const { return true; }

QRectF VirtualKeyboardInputContext::keyboardRect() const { return QRectF(); }

void VirtualKeyboardInputContext::showInputPanel() {
    d->Visible = true;
    QPlatformInputContext::showInputPanel();
    emitInputPanelVisibleChanged();
}

void VirtualKeyboardInputContext::hideInputPanel() {
    d->Visible = false;
    QPlatformInputContext::hideInputPanel();
    emitInputPanelVisibleChanged();
}

bool VirtualKeyboardInputContext::isInputPanelVisible() const {
    return d->Visible;
}

bool VirtualKeyboardInputContext::isAnimating() const { return false; }

void VirtualKeyboardInputContext::setFocusObject(QObject *object) {
    static const int NumericInputHints = Qt::ImhPreferNumbers | Qt::ImhDate |
                                         Qt::ImhTime |
                                         Qt::ImhFormattedNumbersOnly;

    if (!object) {
        return;
    }

    d->FocusItem = dynamic_cast<QQuickItem *>(object);
    if (!d->FocusItem) {
        return;
    }

    bool AcceptsInput = d->FocusItem->inputMethodQuery(Qt::ImEnabled).toBool();
    if (!AcceptsInput) {
        hideInputPanel();
        return;
    }

    // set the focusItem as parent of InputPanel
    if (QObject *item = inputItem()) {
        // ToDo: the InputPanel is set once, so cast can be done at register QQuickItem
        if (QQuickItem *vkbPanel = qobject_cast<QQuickItem*>(inputPanel)) {
            // ToDo: cast of inputItem is overflow ... use d->FocusItem
            if (QQuickItem *quickItem = qobject_cast<QQuickItem*>(item)) {
                const QVariant isRootItem = vkbPanel->property("__isRootItem");
                /*
                    For integrated keyboards, make sure it's a sibling to the overlay. The
                    high z-order will make sure it gets events also during a modal session.
                */
                if (isRootItem.isValid() && !isRootItem.toBool()) {
                    vkbPanel->setParentItem(quickItem->window()->contentItem());
                    vkbPanel->setProperty("__reparented", true);
                }
            }
        }
    }

    visibleConnection = std::make_shared<QMetaObject::Connection>(QObject::connect(d->FocusItem, &QQuickItem::visibleChanged, this, [&](){
        if(!d->FocusItem->isVisible())
            hideInputPanel();
        else
            showInputPanel();
    }));

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
        d->InputEngine->setUppercase(false);
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

void VirtualKeyboardInputContext::ensureFocusedObjectVisible() {
    if (!d->Visible || !d->Flickable || d->InputEngine->isAnimating()) {
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
    return VirtualKeyboardInputContext::instance()->d->InputEngine;
}

QObject *VirtualKeyboardInputContext::inputPanelProvider(
    QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return VirtualKeyboardInputContext::instance()->d->inputPanelIface;
}

QObject *VirtualKeyboardInputContext::inputContextProvider(
    QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    const auto instance=VirtualKeyboardInputContext::instance();
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QQmlEngine::setObjectOwnership(instance, QQmlEngine::CppOwnership);
#else
    QJSEngine::setObjectOwnership(instance,QJSEngine::CppOwnership);
#endif
    return instance;
}
