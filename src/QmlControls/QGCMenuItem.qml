import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls

MenuItem {
    id: control
    
    // MenuItem doesn't support !visible so we have to hack it in
    height: visible ? implicitHeight : 0
    
    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }
    
    background: Rectangle {
        color: control.highlighted ? qgcPal.buttonHighlight : "transparent"
        radius: ScreenTools.buttonBorderRadius * 0.8
        
        // Smooth highlight transition
        Behavior on color {
            ColorAnimation { duration: 100; easing.type: Easing.InOutQuad }
        }
    }
    
    contentItem: Text {
        text: control.text
        font: control.font
        color: control.highlighted ? qgcPal.buttonHighlightText : qgcPal.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        
        // Smooth color transition
        Behavior on color {
            ColorAnimation { duration: 100; easing.type: Easing.InOutQuad }
        }
    }
}
