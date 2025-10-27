/****************************************************************************
 *
 * (c) 2009-2024 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


/// @file
///     @author Don Gagne <don@thegagnes.com>

#include "QGCPalette.h"
#include "QGCCorePlugin.h"

#include <QtCore/QDebug>

QList<QGCPalette*>   QGCPalette::_paletteObjects;

QGCPalette::Theme QGCPalette::_theme = QGCPalette::Dark;

QMap<int, QMap<int, QMap<QString, QColor>>> QGCPalette::_colorInfoMap;

QStringList QGCPalette::_colors;

QGCPalette::QGCPalette(QObject* parent) :
    QObject(parent),
    _colorGroupEnabled(true)
{
    if (_colorInfoMap.isEmpty()) {
        _buildMap();
    }

    // We have to keep track of all QGCPalette objects in the system so we can signal theme change to all of them
    _paletteObjects += this;
}

QGCPalette::~QGCPalette()
{
    bool fSuccess = _paletteObjects.removeOne(this);
    if (!fSuccess) {
        qWarning() << "Internal error";
    }
}

void QGCPalette::_buildMap()
{
    //                                      Light                 Dark
    //                                      Disabled   Enabled    Disabled   Enabled
    // Modern UI Update: Enhanced color palette with vibrant, contemporary colors
    DECLARE_QGC_COLOR(window,               "#f8f9fa", "#f8f9fa", "#1a1d23", "#1a1d23")
    DECLARE_QGC_COLOR(windowTransparent,    "#ccf8f9fa", "#ccf8f9fa", "#cc1a1d23", "#cc1a1d23")
    DECLARE_QGC_COLOR(windowShadeLight,     "#9ca3af", "#6b7280", "#6b7280", "#4b5563")
    DECLARE_QGC_COLOR(windowShade,          "#e5e7eb", "#e5e7eb", "#2d3139", "#2d3139")
    DECLARE_QGC_COLOR(windowShadeDark,      "#d1d5db", "#d1d5db", "#23262d", "#23262d")
    DECLARE_QGC_COLOR(text,                 "#9ca3af", "#111827", "#9ca3af", "#f9fafb")
    DECLARE_QGC_COLOR(windowTransparentText,"#9ca3af", "#111827", "#9ca3af", "#f9fafb")
    DECLARE_QGC_COLOR(warningText,          "#dc2626", "#dc2626", "#ef4444", "#ef4444")
    DECLARE_QGC_COLOR(button,               "#ffffff", "#ffffff", "#374151", "#4b5563")
    DECLARE_QGC_COLOR(buttonBorder,         "#e5e7eb", "#d1d5db", "#4b5563", "#6b7280")
    DECLARE_QGC_COLOR(buttonText,           "#9ca3af", "#1f2937", "#d1d5db", "#f9fafb")
    DECLARE_QGC_COLOR(buttonHighlight,      "#f3f4f6", "#3b82f6", "#475569", "#3b82f6")
    DECLARE_QGC_COLOR(buttonHighlightText,  "#374151", "#ffffff", "#f9fafb", "#ffffff")
    DECLARE_QGC_COLOR(primaryButton,        "#6b7280", "#3b82f6", "#6b7280", "#3b82f6")
    DECLARE_QGC_COLOR(primaryButtonText,    "#ffffff", "#ffffff", "#ffffff", "#ffffff")
    DECLARE_QGC_COLOR(textField,            "#ffffff", "#ffffff", "#374151", "#2d3139")
    DECLARE_QGC_COLOR(textFieldText,        "#9ca3af", "#111827", "#d1d5db", "#f9fafb")
    DECLARE_QGC_COLOR(mapButton,            "#6b7280", "#1f2937", "#6b7280", "#1f2937")
    DECLARE_QGC_COLOR(mapButtonHighlight,   "#6b7280", "#3b82f6", "#6b7280", "#3b82f6")
    DECLARE_QGC_COLOR(mapIndicator,         "#6b7280", "#3b82f6", "#6b7280", "#3b82f6")
    DECLARE_QGC_COLOR(mapIndicatorChild,    "#6b7280", "#60a5fa", "#6b7280", "#60a5fa")
    DECLARE_QGC_COLOR(colorGreen,           "#059669", "#059669", "#10b981", "#10b981") 
    DECLARE_QGC_COLOR(colorYellow,          "#d97706", "#d97706", "#fbbf24", "#fbbf24")  
    DECLARE_QGC_COLOR(colorYellowGreen,     "#84cc16", "#84cc16", "#a3e635", "#a3e635")  
    DECLARE_QGC_COLOR(colorOrange,          "#ea580c", "#ea580c", "#f97316", "#f97316")  
    DECLARE_QGC_COLOR(colorRed,             "#dc2626", "#dc2626", "#ef4444", "#ef4444")
    DECLARE_QGC_COLOR(colorGrey,            "#6b7280", "#6b7280", "#9ca3af", "#9ca3af")
    DECLARE_QGC_COLOR(colorBlue,            "#2563eb", "#2563eb", "#3b82f6", "#3b82f6")
    DECLARE_QGC_COLOR(alertBackground,      "#fef3c7", "#fef3c7", "#451a03", "#451a03")
    DECLARE_QGC_COLOR(alertBorder,          "#d97706", "#d97706", "#f59e0b", "#f59e0b")
    DECLARE_QGC_COLOR(alertText,            "#92400e", "#92400e", "#fbbf24", "#fbbf24")
    DECLARE_QGC_COLOR(missionItemEditor,    "#6b7280", "#dbeafe", "#6b7280", "#1e3a8a")
    DECLARE_QGC_COLOR(toolStripHoverColor,  "#6b7280", "#bfdbfe", "#6b7280", "#1e40af")
    DECLARE_QGC_COLOR(statusFailedText,     "#9ca3af", "#dc2626", "#9ca3af", "#ef4444")
    DECLARE_QGC_COLOR(statusPassedText,     "#9ca3af", "#059669", "#9ca3af", "#10b981")
    DECLARE_QGC_COLOR(statusPendingText,    "#9ca3af", "#d97706", "#9ca3af", "#fbbf24")
    DECLARE_QGC_COLOR(toolbarBackground,    "#00f8f9fa", "#00f8f9fa", "#001a1d23", "#001a1d23")
    DECLARE_QGC_COLOR(toolbarDivider,       "#00000000", "#00000000", "#00000000", "#00000000")
    DECLARE_QGC_COLOR(groupBorder,          "#d1d5db", "#d1d5db", "#4b5563", "#4b5563")

    // Colors not affecting by theming - Modern brand colors
    //                                              Disabled    Enabled
    DECLARE_QGC_NONTHEMED_COLOR(brandingPurple,     "#7c3aed", "#7c3aed")
    DECLARE_QGC_NONTHEMED_COLOR(brandingBlue,       "#3b82f6", "#3b82f6")
    DECLARE_QGC_NONTHEMED_COLOR(toolStripFGColor,   "#9ca3af", "#f9fafb")

    // Colors not affecting by theming or enable/disable
    DECLARE_QGC_SINGLE_COLOR(mapWidgetBorderLight,          "#ffffff")
    DECLARE_QGC_SINGLE_COLOR(mapWidgetBorderDark,           "#000000")
    DECLARE_QGC_SINGLE_COLOR(mapMissionTrajectory,          "#be781c")
    DECLARE_QGC_SINGLE_COLOR(surveyPolygonInterior,         "green")
    DECLARE_QGC_SINGLE_COLOR(surveyPolygonTerrainCollision, "red")

// Colors for UTM Adapter
#ifdef QGC_UTM_ADAPTER
    DECLARE_QGC_COLOR(switchUTMSP,        "#b0e0e6", "#b0e0e6", "#b0e0e6", "#b0e0e6");
    DECLARE_QGC_COLOR(sliderUTMSP,        "#9370db", "#9370db", "#9370db", "#9370db");
    DECLARE_QGC_COLOR(successNotifyUTMSP, "#3cb371", "#3cb371", "#3cb371", "#3cb371");
#endif
}

void QGCPalette::setColorGroupEnabled(bool enabled)
{
    _colorGroupEnabled = enabled;
    emit paletteChanged();
}

void QGCPalette::setGlobalTheme(Theme newTheme)
{
    // Mobile build does not have themes
    if (_theme != newTheme) {
        _theme = newTheme;
        _signalPaletteChangeToAll();
    }
}

void QGCPalette::_signalPaletteChangeToAll()
{
    // Notify all objects of the new theme
    for (QGCPalette *palette : std::as_const(_paletteObjects)) {
        palette->_signalPaletteChanged();
    }
}

void QGCPalette::_signalPaletteChanged()
{
    emit paletteChanged();
}
