import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import QGroundControl
import QGroundControl.Controls


RadioButton {
    id:             control
    font.family:    ScreenTools.normalFontFamily
    font.pointSize: ScreenTools.defaultFontPointSize

    property color  textColor:  _qgcPal.text
    property var    _qgcPal:    QGCPalette { colorGroupEnabled: enabled }
    property bool   _noText:    text === ""

    indicator: Rectangle {
        implicitWidth:          ScreenTools.radioButtonIndicatorSize
        implicitHeight:         width
        color:                  control.checked ? _qgcPal.brandingBlue : "white"
        border.color:           control.checked ? _qgcPal.brandingBlue : _qgcPal.text
        border.width:           2
        radius:                 height / 2
        opacity:                control.enabled ? 1 : 0.5
        x:                      control.leftPadding
        y:                      parent.height / 2 - height / 2
        
        // Modern shadow
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 1
            radius: 3
            samples: 7
            color: "#40000000"
            transparentBorder: true
        }
        
        // Smooth color transition
        Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }
        
        Behavior on border.color {
            ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }
        
        Rectangle {
            anchors.centerIn:   parent
            // Width should be an odd number to be centralized by the parent properly
            width:              2 * Math.floor(parent.width / 4) + 1
            height:             width
            antialiasing:       true
            radius:             height * 0.5
            color:              "white"
            visible:            control.checked
            opacity:            control.checked ? 1 : 0
            scale:              control.checked ? 1 : 0.5
            
            // Smooth check animation
            Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
            }
            
            Behavior on scale {
                NumberAnimation { duration: 150; easing.type: Easing.OutBack }
            }
        }
    }

    contentItem: Text {
        text:               control.text
        font.family:        control.font.pointSize
        font.pointSize:     control.font.pointSize
        font.bold:          control.font.bold
        color:              control.textColor
        opacity:            enabled ? 1.0 : 0.3
        verticalAlignment:  Text.AlignVCenter
        leftPadding:        control.indicator.width + (_noText ? 0 : ScreenTools.defaultFontPixelWidth * 0.25)
    }

}
