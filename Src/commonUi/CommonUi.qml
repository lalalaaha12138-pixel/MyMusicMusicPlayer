import QtQuick 2.0
import QtQuick.Window 2.12

Window {
    id:window

    //无边框
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowMaximizeButtonHint |
           Qt.WindowMinimizeButtonHint |Qt.WindowSystemMenuHint
    MouseArea{
        property point beforePiont: "0,0"
        anchors.fill: parent
        onPressed: {
            beforePiont = Qt.point(mouse.x,mouse.y)

        }
        onPositionChanged: {
            window.x += mouse.x - beforePiont.x
            window.y += mouse.y - beforePiont.y
        }
    }
}
