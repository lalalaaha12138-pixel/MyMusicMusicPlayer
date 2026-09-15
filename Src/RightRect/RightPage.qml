import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import "./minmax"
import "./log"
import "./seach"
Rectangle{
    Seach{
        id:seach
        anchors.left: parent.left
        anchors.verticalCenter: minmax.verticalCenter
    }

    Log{
        id:otherRow
        anchors.verticalCenter: minmax.verticalCenter
        anchors.rightMargin: 20
        anchors.right: minmax.left
    }
    Minmax{
        id:minmax
        //        anchors.left: logandchange.left
        anchors.right: parent.right
        anchors.top: parent.top

        width: 180
        height: 60
    }




}




