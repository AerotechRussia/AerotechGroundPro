import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import QGroundControl
import QGroundControl.Controls


Item {
    id: _root

    signal          clicked()
    property alias  buttonImage:    button.source
    property real   radius:         ScreenTools.isMobile ? ScreenTools.defaultFontPixelHeight * 1.75 : ScreenTools.defaultFontPixelHeight * 1.25
    property bool   rotateImage:    false
    property bool   lightBorders:   true

    width:  radius * 2
    height: radius * 2

    property bool checked: false
    property ButtonGroup buttonGroup: null

    QGCPalette { id: qgcPal }

    onButtonGroupChanged: {
        if (buttonGroup) {
            buttonGroup.addButton(_root)
        }
    }

    onRotateImageChanged: {
        if (rotateImage) {
            imageRotation.running = true
        } else {
            imageRotation.running = false
            button.rotation = 0
        }
    }

    Rectangle {
        id:             buttonRect
        anchors.fill:   parent
        radius:         width / 2
        border.width:   ScreenTools.defaultFontPixelHeight * 0.0625
        border.color:   lightBorders ? qgcPal.mapWidgetBorderLight : qgcPal.mapWidgetBorderDark
        color:          checked ? qgcPal.buttonHighlight : qgcPal.button
        
        // Modern circular shadow
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: mouseArea.pressed ? 2 : 4
            radius: mouseArea.pressed ? 4 : 8
            samples: 17
            color: "#60000000"
            transparentBorder: true
        }
        
        // Smooth color transition
        Behavior on color {
            ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }
        
        // Press scale effect
        scale: mouseArea.pressed ? 0.95 : 1.0
        
        Behavior on scale {
            NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
        }

        QGCColoredImage {
            id:                 button
            anchors.fill:       parent
            anchors.margins:    parent.width * 0.15
            sourceSize.height:  parent.height
            fillMode:           Image.PreserveAspectFit
            mipmap:             true
            smooth:             true
            color:              checked ? qgcPal.buttonHighlightText : qgcPal.buttonText

            RotationAnimation on rotation {
                id:             imageRotation
                loops:          Animation.Infinite
                from:           0
                to:             360
                duration:       500
                running:        false
            }
        }
        
        MouseArea {
            id:             mouseArea
            anchors.fill:   parent
            onClicked: {
                checked = !checked
                _root.clicked()
            }
        }
    }
}
