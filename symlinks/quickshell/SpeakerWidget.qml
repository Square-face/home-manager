import QtQuick
import QtQuick.Controls
import Quickshell
<<<<<<< HEAD
import Quickshell.Widgets
=======
>>>>>>> refs/remotes/origin/main
import Quickshell.Services.Pipewire
import QtQuick.Effects

Item {
    id: root
    implicitWidth: indicator.implicitWidth
    implicitHeight: indicator.implicitHeight

    required property PwNode node;
    PwObjectTracker { objects: [ node ] }

    property real percent: node.audio.volume
    property bool muted: node.audio.muted

    property bool showSlider: true

    Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			root.showSlider = true;
			hideTimer.restart();
		}
	}

    Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.showSlider = false
	}

    Button {
        id: button

        implicitWidth: indicator.implicitWidth
        implicitHeight: indicator.implicitHeight

        background: Item {}
        indicator: Text {
            id: indicator
            color: "white"

            text: {
                if (muted) {return " "}
                if (percent == 0) {return "";}
                if (percent < 0.5) {return "";}
                return " "
            }
        }
    }

    LazyLoader {
        loading: true
        active: showSlider

        PopupWindow {
            visible: showSlider
            color: "transparent"

            implicitWidth: slider.implicitWidth
            implicitHeight: slider.implicitHeight

            anchor.item: button
            anchor.rect.x: button.width/2 - width/2
            anchor.rect.y: button.height*1.1

            ClippingWrapperRectangle {
                radius: width/4

                Slider {
                    id: slider

                    value: node.audio.volume
                    onValueChanged: node.audio.volume = value

                    orientation: Qt.Vertical

                    handle: Item { }
                    background: Rectangle {
                        color: "#130f0e"
                        implicitHeight: 120
                        implicitWidth: 22
                        Rectangle {
                            id: handle

                            color: "#d13323"
                            height: slider.height * (1-slider.visualPosition)
                            width: slider.width
                            anchors.bottom: parent.bottom
                        }
                        Text {
                            text: Math.round(percent * 100)
                            font.pixelSize: 11
                            width: slider.width
                            horizontalAlignment: Text.AlignHCenter

                            anchors.top: handle.top
                            states: State {
                                id: "bottom"
                                when: slider.visualPosition >= 0.5
                                AnchorChanges {
                                    target: percentText
                                    anchors.bottom: handle.top
                                    anchors.top: undefined
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
