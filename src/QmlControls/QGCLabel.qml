import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls


Text {
    font.pointSize: ScreenTools.defaultFontPointSize
    font.family:    ScreenTools.normalFontFamily
    color:          qgcPal.text
    antialiasing:   true
    renderType:     Text.NativeRendering
    
    // Improved text rendering with subtle shadow for better readability
    style: Text.Normal
    styleColor: Qt.rgba(0, 0, 0, 0.1)

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }
}
