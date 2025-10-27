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

import QGroundControl
import QGroundControl.Controls



/// Works just like a regular button but it can have a red indicator on the right side displayed
QGCButton {
    property bool indicatorGreen: false ///< true: no indicator shown, false: red indicator shown

    Rectangle {
        anchors.rightMargin:    ScreenTools.defaultFontPixelWidth / 3
        anchors.right:          parent.right
        anchors.verticalCenter: parent.verticalCenter
        width:                  radius * 2
        height:                 width
        radius:                 (ScreenTools.defaultFontPixelHeight * .75) / 2
        color:                  qgcPal.colorRed
        visible:                enabled && !indicatorGreen
        
        // Pulsing animation for attention
        SequentialAnimation on opacity {
            running: visible
            loops: Animation.Infinite
            NumberAnimation { to: 0.3; duration: 800; easing.type: Easing.InOutQuad }
            NumberAnimation { to: 1.0; duration: 800; easing.type: Easing.InOutQuad }
        }
        
        // Inner glow effect
        Rectangle {
            anchors.centerIn: parent
            width: parent.width * 0.6
            height: width
            radius: width / 2
            color: Qt.lighter(qgcPal.colorRed, 1.5)
            opacity: 0.8
        }
    }
    
    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }
}
