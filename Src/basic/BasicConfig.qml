pragma Singleton
import QtQuick 2.12
import Qt.labs.settings 1.0

QtObject {
    id: config

    signal openloginPopup() //打开扫码登录弹窗
    signal otherMouseArea()
    property Settings appearanceSettings: Settings {
        category: "Appearance"
        property string selectedTheme: "dark"
    }

    property string themeName: appearanceSettings.selectedTheme
    readonly property bool isDark: themeName === "dark"

    readonly property color sidebarBackground: isDark ? "#111217" : "#eceef2"
    readonly property color pageBackground: isDark ? "#18191f" : "#f6f7f9"
    readonly property color playerBackground: isDark ? "#24262d" : "#ffffff"
    readonly property color elevatedBackground: isDark ? "#262830" : "#ffffff"
    readonly property color inputBackground: isDark ? "#22242b" : "#ebeef2"
    readonly property color chipBackground: isDark ? "#2b2d35" : "#f1f2f5"
    readonly property color chipHover: isDark ? "#373a44" : "#e4e7ec"
    readonly property color rowHover: isDark ? "#30323a" : "#e9ebef"
    readonly property color titleHover: isDark ? "#EF5E5E" : "#f8eaed"
    readonly property color titleNormal: isDark ? "#13131a" : "#e9ebef"

    readonly property color textPrimary: isDark ? "#f3f4f6" : "#202228"
    readonly property color textSecondary: isDark ? "#9a9daa" : "#737782"
    readonly property color iconNormal: isDark ? "#8c909c" : "#686d78"
    readonly property color iconHover: isDark ? "#ffffff" : "#202228"
    readonly property color border: isDark ? "#3a3d46" : "#d8dbe2"
    readonly property color divider: isDark ? "#3e414a" : "#dfe1e6"

    readonly property color accent: "#e5484d"
    readonly property color accentHover: "#d93d43"
    readonly property color progressTrack: isDark ? "#464952" : "#d7dae0"

    onThemeNameChanged: appearanceSettings.selectedTheme = themeName

    function toggleTheme() {
        themeName = isDark ? "light" : "dark"
    }
}
