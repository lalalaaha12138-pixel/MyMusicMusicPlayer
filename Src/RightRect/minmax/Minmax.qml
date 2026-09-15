import QtQuick 2.0
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import "../../basic"
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
                color: BasicConfig.iconNormal
            }

            layer.effect: ColorOverlay{
                source: miniIcon
                color: BasicConfig.iconHover
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
                color: BasicConfig.iconNormal
            }
            layer.enabled: false
            layer.effect: ColorOverlay{
                source: minimoreIcon
                color: BasicConfig.iconHover
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
            source: expanded
                    ? "qrc:/img/restore-original-transparent-28.png"
                    : "qrc:/img/maximize-original-transparent-28.png"

            readonly property bool expanded: window.visibility === Window.Maximized
                                             || window.visibility === Window.FullScreen
            ColorOverlay{
                anchors.fill: parent
                source: maxIcon
                color: BasicConfig.iconNormal
            }

            layer.enabled: false
            layer.effect: ColorOverlay{
                source: maxIcon
                color: BasicConfig.iconHover
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
                    if (maxIcon.expanded) {
                        window.showNormal()
                    } else {
                        window.showMaximized()
                    }
                }
            }
        }
        Image {
            id: closeIcon
            source: "/img/close-transparent-28.png"
//            source: "qrc:/img/search-transparent-28.png"
            anchors.verticalCenter: parent.verticalCenter
            ColorOverlay{
                anchors.fill: closeIcon
                source: closeIcon
                color: BasicConfig.iconNormal
            }

            layer.enabled: false
            layer.effect: ColorOverlay{
//                        anchors.fill: parent
                source: closeIcon
                color: BasicConfig.iconHover
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
