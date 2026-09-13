import QtQuick 2.0
import QtGraphicalEffects 1.0
Item{

    Row{
        spacing: 15
        id:miniRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 0.02 * window.width

        Image{
            id:miniIcon
            source: "/img/small-transparent-28.png"
            layer.enabled: false
            anchors.verticalCenter: parent.verticalCenter
            ColorOverlay{
                anchors.fill: miniIcon
                source: miniIcon
                color: "#75777f"
            }

            layer.effect: ColorOverlay{
                source: miniIcon
                color: "white"
            }
            MouseArea{
                anchors.fill:parent
                hoverEnabled: true

                onExited: {
                    miniIcon.layer.enabled = false
                }
                onEntered: {
                    miniIcon.layer.enabled = true
                }
            }
        }

        Image {
            id: minimoreIcon
            source: "qrc:/img/minimize-original-transparent-28.png"

            ColorOverlay{
                anchors.fill:parent
                source: minimoreIcon
                color: "#75777f"
            }
            layer.enabled: false
            layer.effect: ColorOverlay{
                source: minimoreIcon
                color: "white"
            }

            MouseArea{
                anchors.fill:parent
                hoverEnabled: true
                onEntered: {
                    minimoreIcon.layer.enabled = true

                }
                onExited: {
                    minimoreIcon.layer.enabled = false

                }

                onClicked: {
                    window.showMinimized()
                }
            }
        }
        Image {
            id: maxIcon
            source: "/img/maximize-original-transparent-28.png"

            property bool flag: true
            ColorOverlay{
                anchors.fill: parent
                source: maxIcon
                color: "#75777f"
            }

            layer.enabled: false
            layer.effect: ColorOverlay{
                source: maxIcon
                color: "white"
            }
            MouseArea{
                hoverEnabled: true
                anchors.fill: parent
                onEntered: {
                    maxIcon.layer.enabled = true

                }
                onExited: {
                    maxIcon.layer.enabled = false
                }

                onClicked: {
                    if (maxIcon.flag == true){
                        window.showMaximized()
                        maxIcon.flag = false
                    }else{
                        window.showNormal()
                        maxIcon.flag = true
                    }
                    maxIcon.source =  window.visibility === Window.Maximized
                            ? "/img/restore-original-transparent-28.png"
                            : "/img/maximize-original-transparent-28.png"
                }
            }
        }
        Image {
            id: closeIcon
            source: "/img/close-transparent-28.png"
            anchors.verticalCenter: parent.verticalCenter
            ColorOverlay{
                anchors.fill: closeIcon
                source: closeIcon
                color: "#75777f"
            }

            layer.enabled: false
            layer.effect: ColorOverlay{
//                        anchors.fill: parent
                source: closeIcon
                color: "white"
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    window.close()
                }
                onEntered: {
                    closeIcon.layer.enabled = true
                }
                onExited: {
                    closeIcon.layer.enabled = false
                }
            }
        }

    }
}
