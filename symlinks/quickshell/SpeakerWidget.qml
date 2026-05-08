import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick.Effects

Item {
    id: root

    property real percent: Audio.primary_sink?.audio.volume
    property bool muted: Audio.primary_sink?.audio.muted

    implicitHeight: indicator.implicitHeight
    implicitWidth: indicator.implicitWidth
    Button {
        id: button
        height: root.height
        width: root.width

        onClicked: popup.visible = !popup.visible

        contentItem: Text {
            id: indicator
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            anchors.left: button.left

            color: muted ? "#AAAAAA" : "white"

            text: {
                if (muted) {return ""}
                if (percent == 0) {return "";}
                if (percent < 0.5) {return "";}
                return ""
            }
        }
        background: Rectangle {
            color: "transparent"

            height: button.height
            width: button.width
        }
    }

    PopupWindow {
        id: popup
        visible: true
        color: "transparent"
        implicitWidth: 20
        implicitHeight: 100
        grabFocus: true

        anchor.item: button
        anchor.rect.y: button.height
        anchor.rect.x: button.width/2 - width/2

        Slider {
            id: control
            orientation: Qt.Vertical
            width: parent.width
            height: parent.height

            value: percent
            onMoved: Audio.primary_sink.audio.volume = value

            snapMode: Slider.SnapAlways
            stepSize: 0.05

            background: Item {
                id: slider_background
                Rectangle {
                    id: mask
                    color: "#111111"
                    width: parent.width
                    height: parent.height
                    radius: width/2
                    layer.enabled: true
                }

                Item {
                    id: source
                    visible: false

                    anchors.fill: mask
                    anchors.bottom: mask.bottom

                    Rectangle {
                        id: filler
                        color: (muted) ? "#B88B58" : "#FFC17A"
                        width: parent.width
                        anchors.bottom: parent.bottom
                        height: parent.height * (1-control.visualPosition)
                    }
                }

                MultiEffect {
                    anchors.fill: mask
                    source: source
                    maskEnabled: true
                    maskSource: mask
                }

                Text {
                    id: value_label
                    property bool side: (parent.height * (control.visualPosition)) < this.height*1.5

                    text: Math.round(percent*100)
                    color: side ?  "#111111" : "#FFFFFF"

                    width: control.width
                    anchors.bottom: slider_background.bottom
                    anchors.bottomMargin: side ? filler.height - this.height*1.2 : filler.height
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            handle: Rectangle {visible: false}
        }
    }
}
