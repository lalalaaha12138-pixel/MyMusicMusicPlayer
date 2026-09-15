import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
import "../../basic"
Row{
    id: search
    spacing: 8
//        y:10


    Rectangle{
        width: 28
        height: 34
        radius: 6
        color: "transparent"
        Image {
            id: leftArrow
            source: "qrc:/img/back-arrow-transparent-28.png"
            anchors.fill:parent
            ColorOverlay{
                source: leftArrow
                color: BasicConfig.iconNormal
            }




            layer.enabled: false
            layer.effect: ColorOverlay{
                source: leftArrow
                color: BasicConfig.iconHover
            }

            MouseArea{
                anchors.fill: leftArrow
                hoverEnabled: true
                onEntered: {
                    leftArrow.layer.enabled = true
                }
                onExited: {
                    leftArrow.layer.enabled = false
                }
            }
        }
    }
    TextField {
        id:serchFiled
        width: 300
        height: 34
        selectByMouse: true
        leftPadding: 40
        placeholderText: "搜索音乐"
        placeholderTextColor: BasicConfig.textSecondary
        color: BasicConfig.textPrimary
        font.pixelSize: 14
        font.family:"微软雅黑 Light"

        background: Rectangle{
            anchors.fill:parent
            radius: 6
            color: BasicConfig.inputBackground
            border.width: 1
            border.color: serchFiled.activeFocus
                          ? BasicConfig.accent : BasicConfig.border
            Behavior on color { ColorAnimation { duration: 160 } }
        }
        Image {
            id: seachIcon
            scale: 1.2
            source: "qrc:/img/search-transparent-28.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            ColorOverlay {
                anchors.fill: seachIcon
                source: seachIcon
                color: BasicConfig.textSecondary
            }
        }
        onPressed: {
            popup.open()
        }
    }
    ListModel{
        id:singModel
        ListElement{singname:"123"}
        ListElement{singname:"124"}
        ListElement{singname:"12511"}
        ListElement{singname:"126"}
        ListElement{singname:"1271111"}
        ListElement{singname:"12822"}
        ListElement{singname:"129999"}
        ListElement{singname:"1299922"}
        ListElement{singname:"1299921"}
        ListElement{singname:"129992244"}
        ListElement{singname:"12999221111"}

    }

    Popup{
        id:popup
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        onClosed: {
            singRepeat.showall = false
            searchFlick.contentY = 0
            //重新渐变textFiled
            serchFiled.focus = false
        }
        padding: 0
        width: parent.width
        height: 475
        y: serchFiled.height + 10
//        property real isClikedFromSearch: serchFiled.activeFocus ? 0 : 1
        background: Rectangle{
            anchors.fill:parent

            color: BasicConfig.elevatedBackground
            border.width: 1
            border.color: BasicConfig.border
            radius: 6
            Behavior on color { ColorAnimation { duration: 160 } }
        }
        contentItem: Flickable{
                 id: searchFlick
                 clip: true
                 contentWidth: width
                 contentHeight: Math.max(height,
                                         popupColumn.y + popupColumn.implicitHeight + 10)
                 flickableDirection: Flickable.VerticalFlick
                 boundsBehavior: Flickable.StopAtBounds
                 onContentHeightChanged: {
                     contentY = Math.min(contentY, Math.max(0, contentHeight - height))
                 }
                 ScrollBar.vertical: ScrollBar {
                     id: searchScrollBar
                     policy: ScrollBar.AsNeeded
                     active: true
                 }

                 Column{

                     id: popupColumn
                     x: 20
                     y: 10
                     width: Math.max(0, searchFlick.width - 40)
                     spacing: 16
                     Item{
                         id:historyItem
                         width:parent.width
                         height: singFlow.y + singFlow.implicitHeight
                         Rectangle{
                             id:historyRect
                             anchors.left: parent.left
                             anchors.leftMargin: 10
                             anchors.top: parent.top
                             anchors.topMargin: 10
                             width: 72
                             height: 28
                             color: "transparent"
                             Label{
                                 anchors.centerIn: parent
                                 text: "历史记录"
                                 color: BasicConfig.textPrimary
                                 font.pixelSize: 16
                                 font.family: "微软雅黑 Light"
                             }
                         }
                         Image {
                             id: deleteIcon
                             anchors.right: parent.right
                             anchors.top: parent.top
                             anchors.topMargin: 10
                             anchors.rightMargin:  20
                             anchors.verticalCenter: historyRect.verticalCenter
                             source: "qrc:/img/trash-transparent-28.png"
                             layer.effect: ColorOverlay{
                                 source: deleteIcon
                                 color: BasicConfig.iconHover
                             }
                             ColorOverlay{
                                 source: deleteIcon
                                 anchors.fill: parent
                                 color: BasicConfig.iconNormal
                             }

                             layer.enabled: false

                             MouseArea{
                                 anchors.fill: parent
                                 hoverEnabled: true
                                 onEntered: {
                                     deleteIcon.layer.enabled = true
                                 }
                                 onExited: {
                                     deleteIcon.layer.enabled = false
                                 }
                                 onClicked: {
                                     singModel.clear()
                                 }
                             }

                         }

                         Flow{
                                  id:singFlow
                                  anchors.top: historyItem.top
                                  anchors.left: parent.left
                                  anchors.right: parent.right
                                  anchors.topMargin: 50
                                  spacing: 10
                                  Repeater{
                                      id:singRepeat

                                      property bool showall: false
                                      model: Math.min(singModel.count, showall ? 10 : 6)
                                      delegate: Rectangle{
                                          id:singDelegate
                                          width: Math.min(dataLabel.implicitWidth + 20, singFlow.width)
                                          height: 32
                                          border.color: BasicConfig.border
                                          border.width: 1
                                          color: historyMouse.containsMouse
                                                 ? BasicConfig.chipHover : BasicConfig.chipBackground
                                          radius: 6
                                          Label{
//         		     	  		                anchors.fill: parent
                                              anchors.centerIn: parent
                                              id:dataLabel
                                              text: singModel.get(index).singname
                                              width: parent.width - 20
                                              elide: Text.ElideRight
                                              font.pixelSize: 14
                                              color: historyMouse.containsMouse
                                                     ? BasicConfig.textPrimary : BasicConfig.textSecondary
                                              font.family: "微软雅黑 Light"
                                              height: 20
                                          }


                                          MouseArea{
                                              id: historyMouse
                                              anchors.fill: parent
                                              hoverEnabled: true
                                              cursorShape: Qt.PointingHandCursor

                                              onClicked: {

                                                  serchFiled.text = singModel.get(index).singname
                                                  popup.close()
                                              }
                                          }
                                      }
                                  }
                                  Rectangle {
                                      id: historyToggle
                                      width: 32
                                      height: 32
                                      visible: singModel.count > 6
                                      radius: 6
                                      border.color: BasicConfig.border
                                      border.width: 1
                                      color: toggleMouse.highlighted
                                             ? BasicConfig.chipHover : BasicConfig.chipBackground

                                      Label {
                                          anchors.centerIn: parent
                                          text: ">"
                                          rotation: singRepeat.showall ? -90 : 90
                                          font.pixelSize: 18
                                          color: toggleMouse.highlighted
                                                 ? BasicConfig.textPrimary : BasicConfig.textSecondary
                                      }
//         		     	  		        ToolTip.visible: toggleMouse.containsMouse
//         		     	  		        ToolTip.text: singRepeat.showall ? "收起" : "展开"
                                      MouseArea {
                                          id: toggleMouse
                                          property bool suppressHover: false
                                          property point clickPosition: Qt.point(0, 0)
                                          readonly property bool highlighted: containsMouse && !suppressHover
                                          anchors.fill: parent
                                          hoverEnabled: true
                                          cursorShape: Qt.PointingHandCursor
                                          onClicked: {
                                              clickPosition = mapToItem(null, mouse.x, mouse.y)
                                              suppressHover = true
                                              singRepeat.showall = !singRepeat.showall
                                          }
                                          onPositionChanged: {
                                              // Compare scene coordinates so Flow relayout does not restore hover.
                                              var position = mapToItem(null, mouse.x, mouse.y)
                                              if (position.x !== clickPosition.x || position.y !== clickPosition.y)
                                                  suppressHover = false
                                          }
                                      }
                                  }
                              }
                     }
                     Item{
                         id:singListItem
//         		           anchors.horizontalCenter: historySearch.horizontalCenter
//         		           anchors.left: parent.left
//         		           anchors.right: parent.right
                         width: parent.width
                         height: hotSearchLabel.height + 12 + hotList.height
                         Label{
                             id:hotSearchLabel
                             color: BasicConfig.textSecondary
                             text:"热搜榜"
                             font.pixelSize: 16
                             font.family: "微软雅黑 Light"

                             anchors.left: parent.left
//         		               anchors.leftMargin: 10
                             anchors.top: parent.top
                             height: 26
                         }

                         ListModel{
                             id:hotListModel
                             ListElement{hotName:"fdfdg22g"}
                             ListElement{hotName:"fdfd2gg"}
                             ListElement{hotName:"fdfdg33g"}
                             ListElement{hotName:"fdfdg13g"}
                             ListElement{hotName:"fdfdg33g"}
                             ListElement{hotName:"fdfdg33g"}
                             ListElement{hotName:"fdfdg1g"}
                             ListElement{hotName:"fdfdg2344g"}
                         }

                         ListView{
                             id:hotList
                             anchors.top: hotSearchLabel.bottom
                             anchors.topMargin: 12
                             anchors.left: parent.left
                             anchors.right: parent.right
                             height: count * 34
                             interactive: false
                             clip: true
                              model: hotListModel
                              delegate: Rectangle{
                                  id: hotDelegate
                                  objectName: "hotSearchDelegate"
                                  width: hotList.width
                                  height: 34
                                  color: hotMouse.containsMouse
                                         ? BasicConfig.rowHover : "transparent"
                                  radius: 4
                                 Label{
                                     id:hotRank
                                     anchors.left: parent.left
                                     anchors.verticalCenter: parent.verticalCenter
                                     width: 30
                                     text: (index + 1) + "."
                                      color: index < 3
                                             ? BasicConfig.accent : BasicConfig.textSecondary
                                      font.pixelSize: 14
                                     font.family: "微软雅黑 Light"
                                 }
                                 Label{
                                     id:hotSong
                                     anchors.left: hotRank.right
                                     anchors.right: parent.right
                                     anchors.verticalCenter: parent.verticalCenter
                                     text: hotName
                                     elide: Text.ElideRight//文字超出控件宽度时，如何用省略号显示
                                      color: BasicConfig.textPrimary
                                      font.pixelSize: 14
                                     font.family: "微软雅黑 Light"

                                 }
                                  MouseArea{
                                      id: hotMouse
                                      anchors.fill:parent
                                      hoverEnabled: true
                                      cursorShape: Qt.PointingHandCursor
                                  }
                             }


                         }
                     }
                 }
        }
    }


    Rectangle{
        id:sound
        width: 34
        height: 34
        color: soundMouse.containsMouse ? BasicConfig.chipHover : "transparent"
        border.color: BasicConfig.border
        border.width: 1
        radius: 6
        Image {
            id: micphone
            source: "qrc:/img/microphone-transparent-28.png"
            anchors.fill: parent
            ColorOverlay{
                anchors.fill: parent
                source: micphone
                color: BasicConfig.iconNormal
            }
        }
        MouseArea{
            id: soundMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }


}

