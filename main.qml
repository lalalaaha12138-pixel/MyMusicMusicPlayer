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
import "./Src/basic"
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
        color: BasicConfig.sidebarBackground
        Behavior on color { ColorAnimation { duration: 160 } }
    }
    RightPage{
        id: rightPage
        anchors.left: leftPage.right
        anchors.bottom: bottonPage.top
        anchors.top : parent.top
        anchors.right: parent.right
        height: 100
        color: BasicConfig.pageBackground
        Behavior on color { ColorAnimation { duration: 160 } }
//        color:"yellow"
    }
    BottonPage{
        id:bottonPage
        height: 100
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: BasicConfig.playerBackground
        Behavior on color { ColorAnimation { duration: 160 } }
    }



    Connections{
        target:BasicConfig

        onOpenloginPopup: {
            logInPopup.open()
        }
    }

    Popup{

        id : logInPopup
        height: 500
        width: 350
        anchors.centerIn: parent
        function resetAnimation() {
            showAnimation.stop()
            showAnimation.expanded = false
            otherPic.x = 40
            otherPic.opacity = 1
            qrcode.x = 200
            qrcode.scale = 1.2
        }

        function animateQrCode(expanded) {
            showAnimation.expanded = expanded
            showAnimation.restart()
        }

        onAboutToShow: {
            resetAnimation()
        }
        closePolicy:Popup.NoAutoClose
        clip: true
        background: Rectangle{
            id:logInPopupBackgroundRect
            color: BasicConfig.elevatedBackground
            border.width: 1
            border.color: BasicConfig.border
            radius: 5
            anchors.fill:parent
            Behavior on color { ColorAnimation { duration: 160 } }
             Image {
                id: popupCloseIcon
                source: "qrc:/img/close-transparent-28.png"
                anchors.right: parent.right
                anchors.top: parent.top
                ColorOverlay{
                    anchors.fill: parent
                    source: popupCloseIcon
                    color: BasicConfig.iconNormal

                }

                layer.enabled: false
                layer.effect: ColorOverlay{
                    source: popupCloseIcon
                    color: BasicConfig.iconHover
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        popupCloseIcon.layer.enabled = true
                    }
                    onExited: {
                        popupCloseIcon.layer.enabled = false
                    }
                    onClicked:
                        logInPopup.close()


                }

            }
            Label{
                id:logText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 50

                text: "NONONO"
                font.pixelSize: 28
                font.family: "微软雅黑 Light"
                color: BasicConfig.textPrimary

            }

            Image {
                x:40
                y:150
                scale: 1.2
                id: otherPic
                source: "qrc:/othersPic/others/pic.png"
            }
            Image {
//                 anchors.centerIn: parent
                  x : 200
                  y : 200
                  scale: 1.2
                  id: qrcode
                  source: "qrc:/othersPic/others/qrcode.png"
             }
             MouseArea {
                 // Keep the hit area fixed while the QR code moves and scales.
                 x: 200
                 y: 200
                 width: qrcode.width
                 height: qrcode.height
                 hoverEnabled: true
                 onEntered: logInPopup.animateQrCode(true)
                 onExited: logInPopup.animateQrCode(false)
             }

        }

       ParallelAnimation{
            id:showAnimation
            property bool expanded: false

            NumberAnimation {
                target:otherPic
                property: "x"
                duration: 400
                to: showAnimation.expanded ? 200 : 40
            }
//            NumberAnimation {
//                target:otherPic
//                property: "y"
//                duration: 400
//                from: showAnimation.showFlag ? (logInPopupBackgroundRect .width - otherPic.implicitWidth)/2 :10
//                to: showAnimation.showFlag ? -60:(logInPopupBackgroundRect .width - otherPic.implicitWidth)/2
//            }
            NumberAnimation {
                target:otherPic
                property: "opacity"
                duration: 400
                to: showAnimation.expanded ? 0 : 1
            }
            NumberAnimation {
                target:qrcode
                property: "x"
                duration: 400
                to: showAnimation.expanded
                    ? (logInPopup.width - qrcode.width) / 2
                    : 200
                easing.type: Easing.Linear
            }
            NumberAnimation{
                target: qrcode
                property: "scale"
                duration: 400
                to: showAnimation.expanded ? 1.4 : 1.2
            }





      }
      Label{
                id:ontherLogWays
                text: "其他登录方式>"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                font.pixelSize: 18
                font.family: "微软雅黑 Light"
                color: BasicConfig.textPrimary
      }
    }


}
