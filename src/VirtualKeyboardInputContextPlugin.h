/**
 * \file VirtualKeyboardInputContextPlugin.h
 *
 * \brief Declaration of VirtualKeyboardInputContextPlugin
 *
 * \author Uwe Kindler
 * \date 08/01/2015
 *
 * Copyright (c) 2015 Uwe Kindler
 */

#ifndef VIRTUALKEYBOARDINPUTCONTEXTPLUGIN_H
#define VIRTUALKEYBOARDINPUTCONTEXTPLUGIN_H

#include <qpa/qplatforminputcontextplugin_p.h>

#include "virtualkeyboard_global.h"

/**
 * Implementation of QPlatformInputContextPlugin
 */
class VirtualKeyboardInputContextPlugin : public QPlatformInputContextPlugin {
    Q_OBJECT

    Q_PLUGIN_METADATA(IID QPlatformInputContextFactoryInterface_iid FILE
                      "cutekeyboard.json")

   public:
    QPlatformInputContext *create(const QString &, const QStringList &);
};

#endif  // VIRTUALKEYBOARDINPUTCONTEXTPLUGIN_H
