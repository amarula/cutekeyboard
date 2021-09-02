#include "EnterKeyActionAttachedType.hpp"

EnterKeyActionAttachedType::EnterKeyActionAttachedType(QObject *parent) : QObject(parent), m_enabled(true)
{

}

bool EnterKeyActionAttachedType::enabled() const
{
    return m_enabled;
}

void EnterKeyActionAttachedType::setEnabled(bool enabled)
{
    if (m_enabled != enabled) {
        m_enabled = enabled;
        emit enabledChanged();
    }
}
