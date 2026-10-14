#ifndef PANELELEVATOR_H
#define PANELELEVATOR_H

#include <QList>
#include <QObject>
#include <QPointer>

class QQuickItem;

/**
 * Keeps the single InputPanel item usable while the focused input item lives
 * in a Qt Quick Controls popup.
 *
 * Popups are hosted by the window overlay, an item stacked above the regular
 * window content. A modal popup makes the overlay consume every press outside
 * the popup, so a keyboard placed in the regular content can neither be seen
 * above the dimmer nor be tapped. While the focus is inside the overlay this
 * class moves the panel into a helper item that sits right above the overlay
 * and mirrors the geometry of the panel's own parent, so the application's
 * bindings keep producing the same on-screen placement. As soon as the focus
 * leaves the overlay the panel goes back to its parent, in its old stacking
 * position.
 */
class PanelElevator : public QObject {
    Q_OBJECT

   public:
    explicit PanelElevator(QObject *parent = nullptr);
    ~PanelElevator() override;

    /**
     * Sets the panel item to manage. Returns false and keeps the current
     * panel when another panel is already registered and alive; \a panel
     * then takes over if that one is destroyed first.
     */
    bool setPanel(QQuickItem *panel);

    /**
     * Places the panel above the overlay when \a focusItem is part of an
     * overlay, otherwise puts it back to where the application placed it.
     * Passing nullptr always puts it back.
     */
    void follow(QQuickItem *focusItem);

   private slots:
    void restore();
    void syncCarrier();
    void panelDestroyed();

   private:
    void adopt(QQuickItem *panel);
    void elevate(QQuickItem *overlay);

    QPointer<QQuickItem> m_panel;
    QList<QPointer<QQuickItem>> m_waitingPanels;
    QPointer<QQuickItem> m_focusItem;
    QPointer<QQuickItem> m_carrier;
    QPointer<QQuickItem> m_overlay;
    QPointer<QQuickItem> m_homeParent;
    QPointer<QQuickItem> m_homeNextSibling;
};

#endif  // PANELELEVATOR_H
