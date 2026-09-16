import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../basic"

Item {
    id: root

    ListModel {
        id: pickModel
        ListElement {
            cover: "qrc:/othersPic/others/liangjieshi.png"
            title: "亮剑：经典名场面"
            description: "热门精选"
        }
        ListElement {
            cover: "qrc:/othersPic/others/liang.png"
            title: "DeepSeek 只要五元？"
            description: "科技趣闻"
        }
        ListElement {
            cover: "qrc:/othersPic/others/naiwa.png"
            title: "治愈系睡前时光"
            description: "轻松一刻"
        }
        ListElement {
            cover: "qrc:/othersPic/others/lulu.png"
            title: "萌趣日常片段"
            description: "今日治愈"
        }
        ListElement {
            cover: "qrc:/othersPic/others/doubao.png"
            title: "豆包 PC 端新体验"
            description: "新鲜速递"
        }
        ListElement {
            cover: "qrc:/othersPic/others/juan.png"
            title: "热门名场面合集"
            description: "人气视频"
        }
    }

    Flickable {
        id: pickFlick
        anchors.fill: parent
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        //使用的是Flickable的宽度，代表不能横向移动
        contentWidth: width
        contentHeight: pickGrid.implicitHeight + 24

        Grid {
            id: pickGrid
            readonly property int columnCount: width >= 760 ? 3 : (width >= 500 ? 2 : 1)
            readonly property real cardWidth: (width - spacing * (columnCount - 1)) / columnCount

            x: 0
            y: 10
            width: pickFlick.width - 12
            columns: columnCount
            spacing: 16

            Repeater {
                model: pickModel

                delegate: Rectangle {
                    id: pickCard
                    readonly property bool hovered: cardMouse.containsMouse
                    readonly property real coverCrop: 2

                    width: pickGrid.cardWidth
                    height: coverFrame.height + 48
                    radius: 10
                    clip: true
                    color: BasicConfig.elevatedBackground
                    border.width: 1
                    border.color: hovered ? BasicConfig.accent : BasicConfig.border
                    scale: hovered ? 1.01 : 1.0
                    z: hovered ? 1 : 0

                    Behavior on color {
                        ColorAnimation { duration: 160 }
                    }

                    Behavior on border.color {
                        ColorAnimation { duration: 120 }
                    }

                    Behavior on scale {
                        NumberAnimation {
                            duration: 120
                            easing.type: Easing.OutCubic
                        }
                    }

                    Item {
                        id: coverFrame
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: width * 9 / 16
                        clip: true

                        Image {
                            anchors.fill: parent
                            anchors.margins: -pickCard.coverCrop
                            source: cover
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                        }
                    }

                    Label {
                        id: titleLabel
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: coverFrame.bottom
                        anchors.topMargin: 6
                        text: title
                        color: BasicConfig.textPrimary
                        font.family: "微软雅黑 Light"
                        font.pixelSize: 14
                        elide: Text.ElideRight
                    }

                    Label {
                        anchors.left: titleLabel.left
                        anchors.right: titleLabel.right
                        anchors.top: titleLabel.bottom
                        anchors.topMargin: 2
                        text: description
                        color: BasicConfig.textSecondary
                        font.family: "微软雅黑 Light"
                        font.pixelSize: 11
                        elide: Text.ElideRight
                    }

                    MouseArea {
                        id: cardMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }

        ScrollBar.vertical: ScrollBar {
            policy: pickFlick.contentHeight > pickFlick.height
                    ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff
        }
    }
}
