/**
 * \file DeclarativeInputEngine.h
 *
 * \brief Declaration of CDeclarativeInputEngine
 *
 * \author Uwe Kindler
 * \date 08/01/2015
 *
 * Copyright (c) 2015 Uwe Kindler
 */

#ifndef DECLARATIVEINPUTENGINE_H
#define DECLARATIVEINPUTENGINE_H

#include <QObject>
#include <QRect>

struct DeclarativeInputEnginePrivate;

/**
 * The input engine provides input context information and is responsible
 * for routing input events to focused QML items.
 * The InputEngine can be accessed as singleton instance from QML
 */
class DeclarativeInputEngine : public QObject
{
    Q_OBJECT

    // clang-format off
    Q_PROPERTY(QRect keyboardRectangle READ keyboardRectangle WRITE setKeyboardRectangle NOTIFY keyboardRectangleChanged FINAL)
    Q_PROPERTY(bool animating READ isAnimating WRITE setAnimating NOTIFY animatingChanged FINAL)
    Q_PROPERTY(int inputMode READ inputMode WRITE setInputMode NOTIFY inputModeChanged FINAL)
    // clang-format on

public:
    /**
     * The InputMode enum provides a list of valid input modes
     */
    enum InputMode { Latin, Numeric, Dialable };
    Q_ENUMS(InputMode)

    /**
     * Creates a dclarative input engine with the given parent
     */
    explicit DeclarativeInputEngine(QObject *parent = 0);

    /**
     * Virtual destructor
     */
    virtual ~DeclarativeInputEngine();

    /**
     * Returns the kesyboard rectangle
     */
    QRect keyboardRectangle() const;

    /**
     * Returns the animating status
     */
    bool isAnimating() const;

    /**
     * Use this property to set the animating status, for example during UI
     * transitioning states.
     */
    void setAnimating(bool Animating);

    /**
     * Returns the current input mode
     * \see InputMode for a list of valid input modes
     */
    int inputMode() const;

    /**
     * Use this function to set the current input mode
     * \see InputMode for a list of valid input modes
     */
    void setInputMode(int Mode);

public slots:
    /**
     * Emits a key click event for the given key, text and modifiers.
     * Returns true if the key event was accepted by the input engine.
     * \note Not implemented yet and not used yet
     */
    bool virtualKeyClick(Qt::Key key, const QString &text, Qt::KeyboardModifiers modifiers);

    /**
     * This function sends the given text to the focused QML item
     * \note This function will get replaced by virtualKeyClick function later
     */
    void sendKeyToFocusItem(const QString &keyText);

    /**
     * Reports the active keyboard rectangle to the engine
     */
    void setKeyboardRectangle(const QRect &Rect);

signals:
    /**
     * Notify signal of keyboardRectangle property
     */
    void keyboardRectangleChanged();

    /**
     * Notify signal of animating property
     */
    void animatingChanged();

    /**
     * Notify signal of inputModep property
     */
    void inputModeChanged();

private:
    DeclarativeInputEnginePrivate *d;

    friend struct DeclarativeInputEnginePrivate;

private slots:
    void animatingFinished();
};

#endif // DECLARATIVEINPUTENGINE_H
