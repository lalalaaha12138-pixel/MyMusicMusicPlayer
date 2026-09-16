import QtQuick 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import "./minmax"
import "./log"
import "./seach"
import "../basic"
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



    //
    ListModel{
        id:qsrr
        ListElement{name1:"精选"}
        ListElement{name1:"歌单广场"}
        ListElement{name1:"排行榜"}
        ListElement{name1:"歌手"}
    }
    Item {
        id:titleItem
        anchors.top: parent.top
        anchors.topMargin: 80
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: titleFlow.width
        height: titleFlow.height

        Flow {
            id: titleFlow
            anchors.top: parent.top
            width: 350
            height: 50
            spacing: 10
            Connections{
               target: BasicConfig
               onOtherMouseArea:{
                    titleRepeater.currentIndex = -1
               }

            }

            Repeater {
                id: titleRepeater
                property int currentIndex: -1   // 当前选中项
                model: qsrr

                delegate: Rectangle {
                    id: dsf
                    readonly property bool selected: titleRepeater.currentIndex === index
                    readonly property bool highlighted: selected || titleMouseArea.containsMouse

                    width: modelLabel.width + 16
                    height: modelLabel.height + 8
                    radius: 10
                    color: highlighted ? BasicConfig.titleHover : BasicConfig.titleNormal
                    scale: titleMouseArea.pressed ? 0.97 : (highlighted ? 1.02 : 1.0)

                    Behavior on color {
                        ColorAnimation {
                            duration: 160
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: 120
                            easing.type: Easing.OutCubic
                        }
                    }

                    Label {
                        id: modelLabel
                        anchors.centerIn: parent
                        text: qsrr.get(index).name1
                        font.family: "微软雅黑 Light"
                        font.pixelSize: 20
                        color: BasicConfig.textPrimary
                    }

                    MouseArea {
                        id: titleMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: titleRepeater.currentIndex = index
                    }
                }
            }
        }
    }
    StackView {
        id: cloudMusicCherryPick
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: titleItem.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: 20
        clip: true
        initialItem:"./cherryPick/CherryPick.qml"
    }


}




