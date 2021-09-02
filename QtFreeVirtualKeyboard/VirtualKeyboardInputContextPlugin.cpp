#include "VirtualKeyboardInputContextPlugin.h"

#include "VirtualKeyboardInputContext.h"

#include "EnterKeyAction.hpp"
#include "EnterKeyActionAttachedType.hpp"

QPlatformInputContext *VirtualKeyboardInputContextPlugin::create(const QString &system,
                                                                 const QStringList &paramList)
{
    Q_UNUSED(paramList);

    if (system.compare(system, QStringLiteral("freevirtualkeyboard"), Qt::CaseInsensitive) == 0) {
        return VirtualKeyboardInputContext::instance();
    }

    return 0;
}
