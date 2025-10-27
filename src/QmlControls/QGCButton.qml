import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import QGroundControl
import QGroundControl.Controls


/// Standard push button control:
///     If there is both an icon and text the icon will be to the left of the text
///     If icon only, icon will be centered
Button {
    id:             control
    hoverEnabled:   !ScreenTools.isMobile
    topPadding:     _verticalPadding
    bottomPadding:  _verticalPadding
    leftPadding:    _horizontalPadding
    rightPadding:   _horizontalPadding
    focusPolicy:    Qt.ClickFocus
    font.family:    ScreenTools.normalFontFamily
    text:           ""

    property bool   primary:        false                               ///< primary button for a group of buttons
    property bool   showBorder:     qgcPal.globalTheme === QGCPalette.Light
    property real   backRadius:     ScreenTools.buttonBorderRadius
    property real   heightFactor:   0.5
    property string iconSource:     ""
    property real   fontWeight:     Font.Normal // default for qml Text
    property real   pointSize:      ScreenTools.defaultFontPointSize

    property alias wrapMode:            text.wrapMode
    property alias horizontalAlignment: text.horizontalAlignment
    property alias backgroundColor:     backRect.color
    property alias textColor:           text.color

    property bool   _showHighlight:     enabled && (pressed | checked)

    property int _horizontalPadding:    ScreenTools.defaultFontPixelWidth * 2
    property int _verticalPadding:      Math.round(ScreenTools.defaultFontPixelHeight * heightFactor)

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }

    background: Rectangle {
        id:             backRect
        radius:         backRadius
        implicitWidth:  ScreenTools.implicitButtonWidth
        implicitHeight: ScreenTools.implicitButtonHeight
        border.width:   showBorder ? 1 : 0
        border.color:   qgcPal.buttonBorder
        color:          primary ? qgcPal.primaryButton : qgcPal.button

        // Modern shadow effect
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: _showHighlight ? 1 : 2
            radius: _showHighlight ? 2 : 4
            samples: 9
            color: "#40000000"
            transparentBorder: true
        }

        Rectangle {
            anchors.fill:   parent
            color:          qgcPal.buttonHighlight
            opacity:        _showHighlight ? 1 : control.enabled && control.hovered ? .15 : 0
            radius:         parent.radius
            
            // Smooth transition for hover effect
            Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.InOutQuad }
            }
        }
        
        // Scale animation on press
        transform: Scale {
            origin.x: backRect.width / 2
            origin.y: backRect.height / 2
            xScale: _showHighlight ? 0.98 : 1
            yScale: _showHighlight ? 0.98 : 1
            
            Behavior on xScale {
                NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
            }
            Behavior on yScale {
                NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
            }
        }
    }

    contentItem: RowLayout {
            spacing: ScreenTools.defaultFontPixelWidth

            QGCColoredImage {
                id:                     icon
                Layout.alignment:       Qt.AlignHCenter
                source:                 control.iconSource
                height:                 text.height
                width:                  height
                color:                  text.color
                fillMode:               Image.PreserveAspectFit
                sourceSize.height:      height
                visible:                control.iconSource !== ""
            }

            QGCLabel {
                id:                     text
                Layout.alignment:       Qt.AlignHCenter
                text:                   control.text
                font.pointSize:         control.pointSize
                font.family:            control.font.family
                font.weight:            fontWeight
                color:                  _showHighlight ? qgcPal.buttonHighlightText : (primary ? qgcPal.primaryButtonText : qgcPal.buttonText)
                visible:                control.text !== "" 
            }
    }
}
