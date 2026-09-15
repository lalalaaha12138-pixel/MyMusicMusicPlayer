import QtQuick 2.0
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12

import "../../basic"
Row{
    id:otherRow
    spacing: 10


    //            id:logandchange
    //            height: 60
    //            //        width: 140
    //            anchors.left: parent.left
    //            anchors.top:parent.top
    //            anchors.right: minmax.left
    //            color: "transparent"


    Item{
        width: 28
        height: width
        Image {
            anchors.fill: parent
            id: avatarIcon
            source: "qrc:/img/avatar-outline-transparent-40.png"
        }
        ColorOverlay {
            anchors.fill: avatarIcon
            source: avatarIcon
            color: BasicConfig.iconNormal
        }
    }
    Text {
        id: loadStateText
        text: "未登录"
        color: loginTextMouse.containsMouse
               ? BasicConfig.iconHover : BasicConfig.textSecondary
        font.pixelSize: 14
        font.family: "微软雅黑 Light"
        anchors.verticalCenter: parent.verticalCenter
        MouseArea{
            id: loginTextMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                console.log("yes")
                BasicConfig.openloginPopup()
            }
        }
    }

    //登录下拉

    Image{
        id:loginImage
        source: "qrc:/img/dropdown-transparent-24.png"

        ColorOverlay {
            anchors.fill: loginImage
            source: loginImage
            color: BasicConfig.iconNormal
        }

        layer.enabled: false
        layer.effect: ColorOverlay{
            source: loginImage
            color: BasicConfig.iconHover
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                loginImage.layer.enabled = true
            }
            onExited:{
                loginImage.layer.enabled = false
            }
        }
    }

    Image{
        id:settingIcon
        source: "qrc:/img/settings-original-transparent-28.png"
        ColorOverlay{
            anchors.fill: settingIcon
            source: settingIcon
            color: BasicConfig.iconNormal
        }
        layer.enabled: false
        layer.effect: ColorOverlay{
            source: settingIcon
            color: BasicConfig.iconHover
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                settingIcon.layer.enabled = true
            }
            onExited:{
                settingIcon.layer.enabled = false
            }
        }
    }

    Image{
        id:themeIcon
        source: "qrc:/img/theme-original-transparent-28.png"
        ColorOverlay{
            anchors.fill: themeIcon
            source: themeIcon
            color: BasicConfig.iconNormal
        }
        layer.enabled: false
        layer.effect: ColorOverlay{
            source: themeIcon
            color: BasicConfig.iconHover
        }

        MouseArea{
            id: themeMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            ToolTip.visible: containsMouse
            ToolTip.text: BasicConfig.isDark ? "切换到浅色模式" : "切换到深色模式"
            onEntered: {
                themeIcon.layer.enabled = true
            }
            onExited:{
                themeIcon.layer.enabled = false
            }
            onClicked: BasicConfig.toggleTheme()
        }
    }
    Image{
        id:mailIcon
        source: "qrc:/img/mail-original-transparent-28.png"
        ColorOverlay{
            anchors.fill: mailIcon
            source: mailIcon
            color: BasicConfig.iconNormal
        }
        layer.enabled: false
        layer.effect: ColorOverlay{
            source: mailIcon
            color: BasicConfig.iconHover
        }

        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                mailIcon.layer.enabled = true
            }
            onExited:{
                mailIcon.layer.enabled = false
            }
        }
    }
    //
    Rectangle{
        width: 1
        height: 28

        color: BasicConfig.divider
    }



}
