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
        ListElement{name1:"ddd"}
        ListElement{name1:"bbb"}
        ListElement{name1:"ccc"}
        ListElement{name1:"ddd1"}
    }
    Item{
//       anchors.top: minmax
//       anchors.left: parent.left
//       anchors.leftMargin: 20
       y :80
       anchors.left: parent.left
       anchors.margins: 20
       Flow{
           id:titleFlow
           anchors.top: parent.top
           width: 300
           height: 50
           spacing: 10
           Repeater{
               id:titleRepeater
               model: qsrr
               delegate: Rectangle{
                   id:dsf
                   width: modelLabel.width
                   height: modelLabel.height + modelRect.height + 5
                   color: titleMouseArea.containsMouse ? BasicConfig.iconHover:BasicConfig.iconNormal
                   Label{
                       id:modelLabel
                       anchors.centerIn: parent

                       text:qsrr.get(index).name1
//                       qDebug()<<listmodel1.get(index).name1
                       font.family: "微软雅黑 Light"
                       font.pixelSize:25
                       color: "white"

                   }
                   Rectangle{
                       id:modelRect
                       anchors.top : modelLabel.bottom
                       width: modelLabel.width -3
                       height: 5

                       color: BasicConfig.progressTrack

                   }

                   MouseArea{
                       id:titleMouseArea
                       anchors.fill:parent
                       hoverEnabled: true

                   }

               }
           }
       }
    }

}




