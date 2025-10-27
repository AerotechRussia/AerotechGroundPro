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


Switch {
    id: control

    readonly property int _radius: 3

    QGCPalette {
        id:                 qgcPal
        colorGroupEnabled:  true
    }

    contentItem: QGCLabel {
        text:               control.text
        verticalAlignment:  Text.AlignVCenter
        rightPadding:       control.indicator.width + control.spacing
    }

    indicator: Rectangle {
        implicitWidth: knob.width * 2.2
        implicitHeight: knob.height * 1.3
        x: control.width - width - control.rightPadding
        y: parent.height / 2 - height / 2
        radius: height / 2
        color: control.checked ? qgcPal.brandingBlue : qgcPal.button
        border.color: control.checked ? qgcPal.brandingBlue : qgcPal.buttonBorder
        border.width: 2
        
        // Modern switch shadow
        layer.enabled: true
        layer.effect: InnerShadow {
            horizontalOffset: 0
            verticalOffset: 1
            radius: 2
            samples: 5
            color: "#40000000"
        }
        
        // Smooth color transition
        Behavior on color {
            ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 200; easing.type: Easing.InOutQuad }
        }

        Rectangle {
            id: knob
            x: control.checked ? parent.width - width - 2 : 2
            y: (parent.height - height) / 2
            width: parent.height - 4
            height: width
            radius: height / 2
            color: "white"
            
            // Knob shadow for depth
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 0
                verticalOffset: 2
                radius: 4
                samples: 9
                color: "#80000000"
                transparentBorder: true
            }
            
            // Smooth sliding animation
            Behavior on x {
                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }
            
            // Scale effect on toggle
            scale: control.pressed ? 1.1 : 1.0
            
            Behavior on scale {
                NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
            }
        }
    }
}
