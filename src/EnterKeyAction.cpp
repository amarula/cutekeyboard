#include "EnterKeyAction.hpp"

#include "EnterKeyActionAttachedType.hpp"

EnterKeyActionAttachedType *EnterKeyAction::qmlAttachedProperties(
    QObject *object) {
    return new EnterKeyActionAttachedType(object);
}
