import QtQuick 2.12
import QtQuick.Window 2.12
import Qt.labs.platform 1.0 as Platform
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQml.Models 2.12

import "Src/BottonPage"
import "Src/LeftPage"
import "Src/RightRect"
import "./Src/commonUi"
CommonUi{
    id:window
    visible: true
    width: 1137
    height: 993
    LeftPage{
        width: 255
        id:leftPage
        anchors.bottom: bottonPage.top
        anchors.top: parent.top
        color: "#13131b"
    }
    RightPage{
        id: rightPage
        anchors.left: leftPage.right
        anchors.bottom: bottonPage.top
        anchors.top : parent.top
        anchors.right: parent.right
        height: 100
        color: "#1a1a21"
//        color:"yellow"
    }
    BottonPage{
        id:bottonPage
        height: 100
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#2d2d37"
    }
}
