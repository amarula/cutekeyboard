#include "PanelElevator.h"

#include <QQuickItem>
#include <QQuickWindow>

#include <limits>

static bool isWithin(const QQuickItem *item, const QQuickItem *ancestor) {
    for (const QQuickItem *p = item; p; p = p->parentItem()) {
        if (p == ancestor) return true;
    }
    return false;
}

// Popups place their visual item in the window overlay. QQuickOverlay is not
// public API, so it is recognized by its class name only.
static QQuickItem *overlayOf(QQuickItem *item) {
    for (QQuickItem *p = item; p; p = p->parentItem()) {
        if (p->inherits("QQuickOverlay")) return p;
    }
    return nullptr;
}

PanelElevator::PanelElevator(QObject *parent) : QObject(parent) {}

PanelElevator::~PanelElevator() { restore(); }

bool PanelElevator::setPanel(QQuickItem *panel) {
    if (!panel) return false;
    if (m_panel == panel) return true;
    if (m_panel) {
        // Kept for when the current panel goes first, as with a Loader that
        // creates a new panel before deleting the one it replaces.
        m_waitingPanels.removeAll(QPointer<QQuickItem>());
        if (!m_waitingPanels.contains(panel)) m_waitingPanels.append(panel);
        return false;
    }

    adopt(panel);
    return true;
}

void PanelElevator::adopt(QQuickItem *panel) {
    m_panel = panel;
    connect(panel, &QObject::destroyed, this, &PanelElevator::panelDestroyed);
}

void PanelElevator::panelDestroyed() {
    // Once the panel is gone, only the helper item is left to clean up. The
    // next waiting panel, if any, takes over where the focus needs it.
    restore();
    while (!m_panel && !m_waitingPanels.isEmpty()) {
        QQuickItem *next = m_waitingPanels.takeFirst();
        if (next) adopt(next);
    }
    follow(m_focusItem);
}

void PanelElevator::follow(QQuickItem *focusItem) {
    m_focusItem = focusItem;
    QQuickItem *overlay = focusItem ? overlayOf(focusItem) : nullptr;

    // A panel the application already put into the overlay itself needs no
    // help; leave it alone.
    if (overlay && m_panel && !m_carrier && isWithin(m_panel, overlay))
        overlay = nullptr;

    if (overlay)
        elevate(overlay);
    else
        restore();
}

void PanelElevator::elevate(QQuickItem *overlay) {
    if (!m_panel) return;

    if (m_carrier) {
        if (m_overlay == overlay && m_panel->parentItem() == m_carrier) {
            syncCarrier();
            return;
        }
        restore();
    }

    QQuickItem *host = overlay->parentItem();
    QQuickItem *home = m_panel->parentItem();
    if (!host || !home || !overlay->window() ||
        overlay->window() != m_panel->window())
        return;

    const QList<QQuickItem *> siblings = home->childItems();
    const int index = siblings.indexOf(m_panel);
    m_homeNextSibling =
        (index >= 0 && index + 1 < siblings.size()) ? siblings.at(index + 1)
                                                    : nullptr;
    m_homeParent = home;
    m_overlay = overlay;

    // The helper is a sibling of the overlay with the highest z, so it is
    // painted after the overlay, on top of it, and hit-tested before it.
    QQuickItem *carrier = new QQuickItem;
    carrier->setObjectName(QStringLiteral("cutekeyboardPanelCarrier"));
    carrier->setParent(host);
    carrier->setParentItem(host);
    carrier->setZ(std::numeric_limits<qreal>::max());
    m_carrier = carrier;

    connect(home, &QQuickItem::xChanged, this, &PanelElevator::syncCarrier);
    connect(home, &QQuickItem::yChanged, this, &PanelElevator::syncCarrier);
    connect(home, &QQuickItem::widthChanged, this, &PanelElevator::syncCarrier);
    connect(home, &QQuickItem::heightChanged, this,
            &PanelElevator::syncCarrier);
    connect(host, &QQuickItem::widthChanged, this, &PanelElevator::syncCarrier);
    connect(host, &QQuickItem::heightChanged, this,
            &PanelElevator::syncCarrier);
    connect(overlay, &QObject::destroyed, this, &PanelElevator::restore);
    connect(home, &QObject::destroyed, this, &PanelElevator::restore);

    syncCarrier();
    m_panel->setParentItem(carrier);
}

void PanelElevator::restore() {
    QQuickItem *carrier = m_carrier;

    QQuickItem *host = carrier ? carrier->parentItem() : nullptr;
    if (m_homeParent) m_homeParent->disconnect(this);
    if (m_overlay) m_overlay->disconnect(this);
    if (host) host->disconnect(this);

    if (m_panel && carrier && m_panel->parentItem() == carrier) {
        QQuickItem *home = m_homeParent;
        if (!home && m_panel->window()) home = m_panel->window()->contentItem();
        m_panel->setParentItem(home);
        if (home && m_homeNextSibling && m_homeNextSibling != m_panel &&
            m_homeNextSibling->parentItem() == home)
            m_panel->stackBefore(m_homeNextSibling);
    }

    if (carrier) {
        // Deferred, as this can run while an event is being delivered to an
        // item that was just moved out of the helper.
        carrier->setParentItem(nullptr);
        carrier->deleteLater();
    }

    m_carrier = nullptr;
    m_overlay = nullptr;
    m_homeParent = nullptr;
    m_homeNextSibling = nullptr;
}

void PanelElevator::syncCarrier() {
    if (!m_carrier || !m_homeParent) return;
    QQuickItem *host = m_carrier->parentItem();
    if (!host) return;

    const QRectF rect = m_homeParent->mapRectToItem(
        host, QRectF(0, 0, m_homeParent->width(), m_homeParent->height()));
    m_carrier->setPosition(rect.topLeft());
    m_carrier->setSize(rect.size());
}
