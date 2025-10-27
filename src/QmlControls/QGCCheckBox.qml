import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import QGroundControl
import QGroundControl.Controls


CheckBox {
    id:             control
    spacing:        _noText ? 0 : ScreenTools.defaultFontPixelWidth
    focusPolicy:    Qt.ClickFocus

    property color  textColor:          _qgcPal.text
    property bool   textBold:           false
    property real   textFontPointSize:  ScreenTools.defaultFontPointSize

    property var    _qgcPal: QGCPalette { colorGroupEnabled: enabled }
    property bool   _noText: text === ""

    property ButtonGroup buttonGroup: null
    onButtonGroupChanged: {
        if (buttonGroup) {
            buttonGroup.addButton(control)
        }
    }

    contentItem: Text {
        //implicitWidth:  _noText ? 0 : text.implicitWidth + ScreenTools.defaultFontPixelWidth * 0.25
        //implicitHeight: _noText ? 0 : Math.max(text.implicitHeight, ScreenTools.checkBoxIndicatorSize)
        leftPadding:        control.indicator.width + control.spacing
        verticalAlignment:  Text.AlignVCenter
        text:               control.text
        font.pointSize:     textFontPointSize
        font.bold:          control.textBold
        font.family:        ScreenTools.normalFontFamily
        color:              control.textColor
    }

    indicator:  Rectangle {
        implicitWidth:  ScreenTools.implicitCheckBoxHeight
        implicitHeight: implicitWidth
        x:              control.leftPadding
        y:              parent.height / 2 - height / 2
        color:          control.checked ? _qgcPal.brandingBlue : (control.enabled ? "white" : _qgcPal.text)
        border.color:   control.checked ? _qgcPal.brandingBlue : _qgcPal.text
        border.width:   2
        radius:         ScreenTools.buttonBorderRadius * 1.2
        opacity:        control.checkedState === Qt.PartiallyChecked ? 0.5 : 1
        
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

        QGCColoredImage {
            source:             "/qmlimages/checkbox-check.svg"
            color:              "white"
            mipmap:             true
            fillMode:           Image.PreserveAspectFit
            width:              parent.implicitWidth * 0.75
            height:             width
            sourceSize.height:  height
            visible:            control.checked
            anchors.centerIn:   parent
            opacity:            control.checked ? 1 : 0
            
            // Smooth check animation
            Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
            }
            
            scale:              control.checked ? 1 : 0.5
            
            Behavior on scale {
                NumberAnimation { duration: 150; easing.type: Easing.OutBack }
            }
        }
    }
}
