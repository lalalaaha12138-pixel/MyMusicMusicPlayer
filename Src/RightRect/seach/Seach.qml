import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12
Row{
    id: search
//        y:10


    Rectangle{
        width: 28
        height:  35
        radius: 10
        color: "transparent"
        Image {
            id: leftArrow
            source: "qrc:/img/back-arrow-transparent-28.png"
            anchors.fill:parent
            ColorOverlay{
                source: leftArrow
                color: "#75777f"
            }




            layer.enabled: false
            layer.effect: ColorOverlay{
                source: leftArrow
                color: "white"
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
        height: 35
        selectByMouse: true
        leftPadding: 40
        placeholderText:"yes yes"
        placeholderTextColor:"white"
        color: "white"
        font.pixelSize : 16
        font.family:"微软雅黑 Light"

        background: Rectangle{
            anchors.fill:parent
            radius:5
            gradient: Gradient{
                orientation:Gradient.Horizontal
                GradientStop{color: "#21283d";position: 0}
                GradientStop{color: "#382635";position: 1}
            }

            Rectangle{
                id:innerRect
                property real gradientStopNumber: serchFiled.activeFocus ? 0 : 1
                anchors.fill:parent
                anchors.margins: 2
                gradient: Gradient{
                    orientation: Gradient.Horizontal
                    GradientStop{color: "#21283d";position: 0}
                    GradientStop{color: "#382635";position: innerRect.gradientStopNumber}
                }
            }
        }
        Image {
            id: seachIcon
            scale: 1.2
            source: "qrc:/img/search-transparent-28.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
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
        height: 600
        y: serchFiled.height + 10
//        property real isClikedFromSearch: serchFiled.activeFocus ? 0 : 1
        background: Rectangle{
            anchors.fill:parent

            color: "#2d2d37"
            radius: 5
        }
        contentItem: Flickable{
                 id: searchFlick
                 clip: true
                 contentWidth: width
//                 contentHeight: popupColumn.y + popupColumn.implicitHeight + 10
                 contentHeight: 1200
                 flickableDirection: Flickable.VerticalFlick
                 boundsBehavior: Flickable.StopAtBounds
//                 onContentHeightChanged: {
//                     contentY = Math.min(contentY, Math.max(0, contentHeight - height))
//                 }
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
                     spacing: 20
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
                             width: 50
                             height: 30
                             color: "transparent"
                             Label{
                                 anchors.centerIn: parent
                                 text: "历史记录"
                                 color: "white"
                                 font.pixelSize: 20
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
                                 color: "white"
                             }
                             ColorOverlay{
                                 source: deleteIcon
                                 anchors.fill: parent
                                 color: "#75777f"
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
                                  anchors.topMargin : 60
                                  spacing: 20
                                  Repeater{
                                      id:singRepeat

                                      property bool showall: false
                                      model: Math.min(singModel.count, showall ? 10 : 6)
                                      delegate: Rectangle{
                                          id:singDelegate
                                          width: Math.min(dataLabel.implicitWidth + 20, singFlow.width)
                                          height: 40
                                          border.color: "#45454e"
                                          border.width: 1
                                          color: "#2d2d37"
                                          radius: 15
                                          Label{
//         		     	  		                anchors.fill: parent
                                              anchors.centerIn: parent
                                              id:dataLabel
                                              text: singModel.get(index).singname
                                              width: parent.width - 20
                                              elide: Text.ElideRight
                                              font.pixelSize: 20
                                              color: "#ddd"
                                              font.family: "微软雅黑 Light"
                                              height: 25
                                          }


                                          MouseArea{
                                              anchors.fill: parent
                                              hoverEnabled: true
                                              onEntered: {
                                                  dataLabel.color = "#393943"
                                                  singDelegate.color = "white"
                                                  cursorShape = Qt.PointingHandCursor
                                              }
                                              onExited: {
                                                  singDelegate.color = "#2d2d37"
                                                  dataLabel.color = "#ddd"
                                                  cursorShape = Qt.ArrowCursor
                                              }

                                              onClicked: {

                                                  serchFiled.text = singModel.get(index).singname
                                                  popup.close()
                                              }
                                          }
                                      }
                                  }
                                  Rectangle {
                                      id: historyToggle
                                      width: 40
                                      height: 40
                                      visible: singModel.count > 6
                                      radius: 15
                                      border.color: "#45454e"
                                      border.width: 1
                                      color: toggleMouse.highlighted ? "white" : "#2d2d37"

                                      Label {
                                          anchors.centerIn: parent
                                          text: ">"
                                          rotation: singRepeat.showall ? -90 : 90
                                          font.pixelSize: 20
                                          color: toggleMouse.highlighted ? "#393943" : "#ddd"
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
                             color:"#7f7f85"
                             text:"热搜榜"
                             font.pixelSize: 18
                             font.family: "微软雅黑 Light"

                             anchors.left: parent.left
//         		               anchors.leftMargin: 10
                             anchors.top: parent.top
                             height: 30
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
                             height: count * 36
                             interactive: false
                             clip: true
                             model: hotListModel
                             delegate: Rectangle{
                                 width: hotList.width
                                 height: 36
                                 color: "transparent"
                                 Label{
                                     id:hotRank
                                     anchors.left: parent.left
                                     anchors.verticalCenter: parent.verticalCenter
                                     width: 30
                                     text: (index + 1) + "."
                                     color: index < 3 ? "#ff4b4b" : "white"
                                     font.pixelSize: 18
                                     font.family: "微软雅黑 Light"
                                 }
                                 Label{
                                     id:hotSong
                                     anchors.left: hotRank.right
                                     anchors.right: parent.right
                                     anchors.verticalCenter: parent.verticalCenter
                                     text: hotName
                                     elide: Text.ElideRight//文字超出控件宽度时，如何用省略号显示
                                     color: "white"
                                     font.pixelSize: 18
                                     font.family: "微软雅黑 Light"

                                 }
                                 MouseArea{
                                     anchors.fill:parent
                                     hoverEnabled: true
                                     onEntered:
                                         parent.color = "#8f8f93"
                                     onExited:
                                         parent.color = "transparent"
                                 }
                             }


                         }
                     }
                 }
        }
    }


    Rectangle{
        id:sound
        width: 30
        height: 35
        color: "transparent"
        border.color: "#36262f"
        border.width: 1
        radius: 10
        Image {
            id: micphone
            source: "qrc:/img/microphone-transparent-28.png"
            anchors.fill: parent
            ColorOverlay{
                anchors.fill: parent
                source: micphone
                color: "#75777f"
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                sound.color = "#4a3e4e"
            }
            onExited: {
                sound.color = "transparent"
            }
        }
    }


}

