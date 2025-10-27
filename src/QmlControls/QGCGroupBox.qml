/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import QGroundControl
import QGroundControl.Controls


GroupBox {
    id: control

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }

    background: Rectangle {
        y:      control.topPadding - control.padding
        width:  parent.width
        height: parent.height - control.topPadding + control.padding
        color:  qgcPal.windowShade
        radius: ScreenTools.buttonBorderRadius
        border.color: qgcPal.groupBorder
        border.width: 1
        
        // Subtle inset shadow for depth
        layer.enabled: true
        layer.effect: InnerShadow {
            horizontalOffset: 0
            verticalOffset: 1
            radius: 3
            samples: 7
            color: "#20000000"
        }
    }

    label: QGCLabel {
        width:      control.availableWidth
        text:       control.title
        font.weight: Font.Medium
        font.pointSize: ScreenTools.defaultFontPointSize * 1.1
    }
}
