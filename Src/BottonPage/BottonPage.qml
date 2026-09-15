import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import "../basic"
Rectangle{

    id:bottomRect
    property alias progressValue: progressSlider.value
    property alias progressMaximum: progressSlider.maxValue
    // Bind this to MediaPlayer.duration (milliseconds) when playback is connected.
    property int trackDuration: 0

    Row {
        id: playControls
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 3
        spacing: 14

        Item {
            width: 36
            height: 42
            Image {
                id: previousTrackIcon
                width: 28
                height: 28
                anchors.centerIn: parent
                source: "qrc:/img/previous-track-transparent-28.png"
            }
            ColorOverlay {
                anchors.fill: previousTrackIcon
                source: previousTrackIcon
                color: previousMouse.containsMouse
                       ? BasicConfig.iconHover : BasicConfig.iconNormal
            }
            MouseArea {
                id: previousMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                ToolTip.visible: containsMouse
                ToolTip.text: "上一首"
            }
        }

        Rectangle {
            id: playButton
            width: 42
            height: 42
            radius: width / 2
            color: playMouse.containsMouse
                   ? BasicConfig.accentHover : BasicConfig.accent
            scale: playMouse.containsMouse ? 1.06 : 1

            Behavior on color { ColorAnimation { duration: 120 } }
            Behavior on scale { NumberAnimation { duration: 120 } }

            Image {
                id: playIcon
                width: 26
                height: 26
                anchors.centerIn: parent
                source: "qrc:/img/play-transparent-28.png"
            }
            MouseArea {
                id: playMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                ToolTip.visible: containsMouse
                ToolTip.text: "播放"
            }
        }

        Item {
            width: 36
            height: 42
            Image {
                id: nextTrackIcon
                width: 28
                height: 28
                anchors.centerIn: parent
                source: "qrc:/img/next-track-transparent-28.png"
            }
            ColorOverlay {
                anchors.fill: nextTrackIcon
                source: nextTrackIcon
                color: nextMouse.containsMouse
                       ? BasicConfig.iconHover : BasicConfig.iconNormal
            }
            MouseArea {
                id: nextMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                ToolTip.visible: containsMouse
                ToolTip.text: "下一首"
            }
        }
    }

    Row {
        id: utilityControls
        anchors.right: parent.right
        anchors.rightMargin: 24
        anchors.verticalCenter: playControls.verticalCenter
        spacing: 8

        Item {
            width: 36
            height: 40
            Image {
                id: volumeIcon
                width: 28
                height: 28
                anchors.centerIn: parent
                source: "qrc:/img/volume-transparent-28.png"
            }
            ColorOverlay {
                anchors.fill: volumeIcon
                source: volumeIcon
                color: volumeMouse.containsMouse
                       ? BasicConfig.iconHover : BasicConfig.iconNormal
            }
            MouseArea {
                id: volumeMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                ToolTip.visible: containsMouse
                ToolTip.text: "音量"
            }
        }

        Item {
            width: 36
            height: 40
            Image {
                id: playlistAddIcon
                width: 28
                height: 28
                anchors.centerIn: parent
                source: "qrc:/img/playlist-add-transparent-28.png"
            }
            ColorOverlay {
                anchors.fill: playlistAddIcon
                source: playlistAddIcon
                color: playlistMouse.containsMouse
                       ? BasicConfig.iconHover : BasicConfig.iconNormal
            }
            MouseArea {
                id: playlistMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                ToolTip.visible: containsMouse
                ToolTip.text: "添加到播放列表"
            }
        }

        Item {
            width: 36
            height: 40
            Image {
                id: moreIcon
                width: 28
                height: 28
                anchors.centerIn: parent
                source: "qrc:/img/more-horizontal-transparent-28.png"
            }
            ColorOverlay {
                anchors.fill: moreIcon
                source: moreIcon
                color: moreMouse.containsMouse
                       ? BasicConfig.iconHover : BasicConfig.iconNormal
            }
            MouseArea {
                id: moreMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                ToolTip.visible: containsMouse
                ToolTip.text: "更多"
            }
        }
    }



    //滑槽
    Rectangle{
        id:progressSlider
        objectName: "progressSlider"
        color: BasicConfig.progressTrack
        height: progressMouse.containsMouse || progressMouse.pressed ? 6 : 4
        width: bottomRect.width
        anchors.top: parent.top
        radius: height/2
        property real value: 0.1
        property real maxValue: 1
        function valueFromPosition(position) {
            if (width <= 0 || maxValue <= 0)
                return 0

            return Math.max(0, Math.min(maxValue,
                                        position / width * maxValue))
        }
        function progressRatio() {
            if (maxValue <= 0)
                return 0

            return Math.max(0, Math.min(1, value / maxValue))
        }
        function formatTime(milliseconds) {
            var totalSeconds = Math.max(0, Math.floor(milliseconds / 1000))
            var minutes = Math.floor(totalSeconds / 60)
            var seconds = totalSeconds % 60
            return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
        }
        function progressText() {
            var ratio = progressRatio()
            if (bottomRect.trackDuration > 0) {
                return formatTime(ratio * bottomRect.trackDuration)
                        + " / " + formatTime(bottomRect.trackDuration)
            }

            return Math.round(ratio * 100) + "%"
        }

        NumberAnimation {
            id: seekAnimation
            target: progressSlider
            property: "value"
            duration: 180
            easing.type: Easing.OutCubic
        }
        Behavior on height { NumberAnimation { duration: 100 } }
//        Label{
//            id:currentTimelabel
//            text: '02:02'
//            color: "white"
//            font.pixelSize: 12
//            font.family:'黑体'
//            anchors.right: progressSlider.left
//            anchors.rightMargin: 5
//            anchors.verticalCenter: progressContentRect.verticalCenter
//        }
//        Label{
//            id:maxTimelabel
//            text: '03:52'
//            color: "white"
//            font.pixelSize: 12
//            font.family:'黑体'
//            anchors.left: progressSlider.right
//            anchors.leftMargin: 5
//            anchors.verticalCenter: progressContentRect.verticalCenter
//        }

        //已经播放的部分
        Rectangle{
            id:progressContentRect
            objectName: "progressPlayedPart"
            anchors.left: parent.left
            anchors.top: parent.top
            radius: height/2
            anchors.bottom:
            parent.bottom
            color: BasicConfig.accent
            width: progressSlider.maxValue > 0
                   ? progressSlider.width * (progressSlider.value / progressSlider.maxValue)
                   : 0
        }
        //滑块
        Rectangle{
            id:currentPosRect
            objectName: "progressHandle"
            height: 12
            width: height
            radius: width/2
            visible: progressMouse.containsMouse || progressMouse.pressed
            anchors.right: progressContentRect.right
            anchors.rightMargin: -width/2
            anchors.verticalCenter: progressContentRect.verticalCenter

        }
        Rectangle {
            id: progressTip
            z: 2
            width: Math.max(56, progressTipText.implicitWidth + 16)
            height: 28
            x: Math.max(0, Math.min(progressSlider.width - width,
                                    currentPosRect.x + currentPosRect.width / 2 - width / 2))
            y: -height - 10
            radius: 4
            color: BasicConfig.elevatedBackground
            border.width: 1
            border.color: BasicConfig.border
            visible: progressMouse.containsMouse || progressMouse.pressed

            Rectangle {
                width: 8
                height: 8
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.bottom
                rotation: 45
                color: parent.color
                border.width: 1
                border.color: parent.border.color
            }
            Rectangle {
                width: 12
                height: 5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: parent.color
            }
            Text {
                id: progressTipText
                anchors.centerIn: parent
                text: progressSlider.progressText()
                color: BasicConfig.textPrimary
                font.pixelSize: 12
                font.family: "微软雅黑 Light"
            }
        }
        MouseArea{
            id: progressMouse
            x: 0
            y: -5
            width: parent.width
            height: 16
            hoverEnabled: true

            onEntered: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onPressed:{
                seekAnimation.stop()
                seekAnimation.to = progressSlider.valueFromPosition(mouse.x)
                seekAnimation.restart()
            }
            onPressAndHold: {
                seekAnimation.stop()
                progressSlider.value = progressSlider.valueFromPosition(mouse.x)
            }
            onPositionChanged: {
                if (pressed) {
                    seekAnimation.stop()
                    progressSlider.value = progressSlider.valueFromPosition(mouse.x)
                }
            }
            onCanceled: seekAnimation.stop()
       }
    }
}
