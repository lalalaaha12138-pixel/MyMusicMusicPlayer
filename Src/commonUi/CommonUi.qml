import QtQuick 2.12
import QtQuick.Window 2.12
import "../basic"

Window {
    id: window

    minimumWidth: 900
    minimumHeight: 650

    property int resizeMargin: 6
    property point resizeStartGlobal: Qt.point(0, 0)
    property rect resizeStartGeometry: Qt.rect(0, 0, 0, 0)

    //无边框
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowMaximizeButtonHint |
           Qt.WindowMinimizeButtonHint | Qt.WindowSystemMenuHint

    function beginResize(handle, mouse) {
        resizeStartGeometry = Qt.rect(window.x, window.y, window.width, window.height)
        resizeStartGlobal = Qt.point(window.x + handle.x + mouse.x,
                                     window.y + handle.y + mouse.y)
    }

    function resizeFromHandle(handle, mouse) {
        var globalX = window.x + handle.x + mouse.x
        var globalY = window.y + handle.y + mouse.y
        var deltaX = globalX - resizeStartGlobal.x
        var deltaY = globalY - resizeStartGlobal.y
        var nextX = resizeStartGeometry.x
        var nextY = resizeStartGeometry.y
        var nextWidth = resizeStartGeometry.width
        var nextHeight = resizeStartGeometry.height

        if (handle.resizeLeft) {
            nextWidth = resizeStartGeometry.width - deltaX
            nextX = resizeStartGeometry.x + deltaX
            if (nextWidth < window.minimumWidth) {
                nextWidth = window.minimumWidth
                nextX = resizeStartGeometry.x + resizeStartGeometry.width - nextWidth
            }
        } else if (handle.resizeRight) {
            nextWidth = Math.max(window.minimumWidth,
                                 resizeStartGeometry.width + deltaX)
        }

        if (handle.resizeTop) {
            nextHeight = resizeStartGeometry.height - deltaY
            nextY = resizeStartGeometry.y + deltaY
            if (nextHeight < window.minimumHeight) {
                nextHeight = window.minimumHeight
                nextY = resizeStartGeometry.y + resizeStartGeometry.height - nextHeight
            }
        } else if (handle.resizeBottom) {
            nextHeight = Math.max(window.minimumHeight,
                                  resizeStartGeometry.height + deltaY)
        }

        window.x = nextX
        window.y = nextY
        window.width = nextWidth
        window.height = nextHeight
    }

    MouseArea {
        id: allMouseArea
        property point beforePoint: Qt.point(0, 0)
        property bool movingWindow: false

        anchors.fill: parent
        onPressed: {
            beforePoint = Qt.point(mouse.x, mouse.y)
            movingWindow = mouse.y <= 60 && window.visibility === Window.Windowed
        }
        onPositionChanged: {
            if (!pressed || !movingWindow)
                return

            window.x += mouse.x - beforePoint.x
            window.y += mouse.y - beforePoint.y
        }
        onReleased: movingWindow = false
        onCanceled: movingWindow = false

        onClicked: {
            BasicConfig.otherMouseArea()
        }
    }

    Repeater {
        model: ["left", "right", "top", "bottom",
                "top-left", "top-right", "bottom-left", "bottom-right"]

        delegate: MouseArea {
            readonly property bool resizeLeft:
                modelData === "left"
                || modelData === "top-left"
                || modelData === "bottom-left"
            readonly property bool resizeRight:
                modelData === "right"
                || modelData === "top-right"
                || modelData === "bottom-right"
            readonly property bool resizeTop:
                modelData === "top"
                || modelData === "top-left"
                || modelData === "top-right"
            readonly property bool resizeBottom:
                modelData === "bottom"
                || modelData === "bottom-left"
                || modelData === "bottom-right"

            x: resizeLeft ? 0
                          : (resizeRight ? window.width - window.resizeMargin
                                         : window.resizeMargin)
            y: resizeTop ? 0
                         : (resizeBottom ? window.height - window.resizeMargin
                                         : window.resizeMargin)
            width: resizeLeft || resizeRight
                   ? window.resizeMargin
                   : Math.max(0, window.width - window.resizeMargin * 2)
            height: resizeTop || resizeBottom
                    ? window.resizeMargin
                    : Math.max(0, window.height - window.resizeMargin * 2)
            z: 10000
            enabled: window.visibility === Window.Windowed
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            preventStealing: true
            cursorShape: {
                if ((resizeLeft && resizeTop) || (resizeRight && resizeBottom))
                    return Qt.SizeFDiagCursor
                if ((resizeRight && resizeTop) || (resizeLeft && resizeBottom))
                    return Qt.SizeBDiagCursor
                if (resizeLeft || resizeRight)
                    return Qt.SizeHorCursor
                return Qt.SizeVerCursor
            }

            onPressed: window.beginResize(this, mouse)
            onPositionChanged: {
                if (pressed)
                    window.resizeFromHandle(this, mouse)
            }
        }
    }
}
