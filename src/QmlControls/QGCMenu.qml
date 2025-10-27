import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import QGroundControl
import QGroundControl.Controls

Menu {
    id: control
    
    QGCPalette { id: qgcPal; colorGroupEnabled: true }
    
    background: Rectangle {
        color: qgcPal.window
        radius: ScreenTools.buttonBorderRadius
        border.color: qgcPal.groupBorder
        border.width: 1
        
        // Modern menu shadow
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 25
            color: "#80000000"
            transparentBorder: true
        }
    }
    
    // Add smooth enter/exit animations
    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 150
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            property: "scale"
            from: 0.95
            to: 1.0
            duration: 150
            easing.type: Easing.OutBack
        }
    }
    
    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 100
            easing.type: Easing.InQuad
        }
    }
}
