#include "VirtualKeyboardInputContextPlugin.h"

#include "EnterKeyAction.hpp"
#include "EnterKeyActionAttachedType.hpp"
#include "VirtualKeyboardInputContext.h"

QPlatformInputContext *VirtualKeyboardInputContextPlugin::create(
    const QString &system, const QStringList &paramList) {
    Q_UNUSED(paramList);

    if (system.compare(system, QStringLiteral("cutekeyboard"),
                       Qt::CaseInsensitive) == 0) {
        return VirtualKeyboardInputContext::instance();
    }

    return 0;
}
