import QtQuick 2.0
import QtGraphicalEffects 1.0
import "../Minmax"
Rectangle{
    Row{
        id:otherRow
        spacing: 10
        anchors.verticalCenter: minmax.verticalCenter
        anchors.rightMargin: 20
        anchors.right: minmax.left

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
        }
        Text {
            id: loadStateText
            text: "未登录"
            color:"#75777f"
            font.pixelSize: 14
            font.family: "微软雅黑 Light"
            anchors.verticalCenter: avatarIcon.verticalAlignment
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    loadStateText.color = "white"
                }
                onExited: {
                    loadStateText.color = "#75777f"

                }
            }
        }

        //登录下拉

        Image{
            id:loginImage
            source: "qrc:/img/dropdown-transparent-24.png"

            layer.enabled: false
            layer.effect: ColorOverlay{
                source: loginImage
                color: "white"
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
                color: "#75777f"
            }
            layer.enabled: false
            layer.effect: ColorOverlay{
                source: settingIcon
                color: "white"
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
                color: "#75777f"
            }
            layer.enabled: false
            layer.effect: ColorOverlay{
                source: themeIcon
                color: "white"
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    themeIcon.layer.enabled = true
                }
                onExited:{
                    themeIcon.layer.enabled = false
                }
            }
        }
        Image{
            id:mailIcon
            source: "qrc:/img/mail-original-transparent-28.png"
            ColorOverlay{
                anchors.fill: mailIcon
                source: mailIcon
                color: "#75777f"
            }
            layer.enabled: false
            layer.effect: ColorOverlay{
                source: mailIcon
                color: "white"
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

            color: "#75777f"
        }



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




