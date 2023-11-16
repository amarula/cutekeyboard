#pragma once

#include <qqml.h>

#include <QObject>

class EnterKeyActionAttachedType;

class EnterKeyAction : public QObject {
    Q_OBJECT

   public:
    static EnterKeyActionAttachedType *qmlAttachedProperties(QObject *object);
};

// QML_DECLARE_TYPE(EnterKeyAction)
QML_DECLARE_TYPEINFO(EnterKeyAction, QML_HAS_ATTACHED_PROPERTIES)
