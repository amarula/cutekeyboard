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
class DeclarativeInputEngine : public QObject {
    Q_OBJECT

    // clang-format off
    Q_PROPERTY(QRect keyboardRectangle READ keyboardRectangle WRITE setKeyboardRectangle NOTIFY keyboardRectangleChanged FINAL)
    Q_PROPERTY(bool animating READ isAnimating WRITE setAnimating NOTIFY animatingChanged FINAL)
    Q_PROPERTY(int inputMode READ inputMode WRITE setInputMode NOTIFY inputModeChanged FINAL)
    Q_PROPERTY(bool uppercase READ isUppercase WRITE setUppercase NOTIFY isUppercaseChanged)
    Q_PROPERTY(bool symbolMode READ isSymbolMode WRITE setSymbolMode NOTIFY isSymbolModeChanged)
    // clang-format on

   public:
    /**
     * The InputLayouts enum provides a list of valid input layouts
     */
    enum InputLayouts {
        En,
        Fr,
        It,
        Es,
        De,
        Nl,
        Pt,
        Cs,
        El,
        Pl,
        Sv,
        Hr,
        CyBs,
        LtBs,
        CySr,
        LtSr,
        EndLayouts
    };
    Q_ENUM(InputLayouts)

    /**
     * The InputMode enum provides a list of valid input modes
     */
    enum InputMode { Letters, DigitsOnly };
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

    bool isUppercase() const;
    void setUppercase(bool uppercase);

    bool isSymbolMode() const;
    void setSymbolMode(bool symbolMode);

    Q_INVOKABLE bool inputLayoutValid(const QString &layout) const;

    /**
     * Use this function to get the correct layout file for each language
     * (some languages share one file)
     */
    Q_INVOKABLE QString fileOfLayout(QString layout);

    /**
     * Use this function to get the correct description for each language
     */
    Q_INVOKABLE QString descriptionOfLayout(QString layout);

    /**
     * Use this function to get the correct 'space'-identifier for each language
     */
    Q_INVOKABLE QString spaceIdentifierOfLayout(QString layout);

   public slots:
    /**
     * Emits a key click event for the given key, text and modifiers.
     * Returns true if the key event was accepted by the input engine.
     * \note Not implemented yet and not used yet
     */
    bool virtualKeyClick(Qt::Key key, const QString &text,
                         Qt::KeyboardModifiers modifiers);

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

    void isUppercaseChanged();
    void isSymbolModeChanged();

   private:
    DeclarativeInputEnginePrivate *d;

    friend struct DeclarativeInputEnginePrivate;

   private slots:
    void animatingFinished();
};

#endif  // DECLARATIVEINPUTENGINE_H
