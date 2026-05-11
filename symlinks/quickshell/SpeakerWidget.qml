import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire

Item {
    id: root
    implicitWidth: indicator.implicitWidth
    implicitHeight: indicator.implicitHeight

    required property PwNode node;
    PwObjectTracker { objects: [ node ] }

    visible: node != null

    property real percent: node?.audio.volume ?? 0
    property bool muted: node?.audio.muted ?? false

    property bool showSlider: false

    Connections {
		target: node?.audio ?? null

		function onVolumeChanged() {
			root.showSlider = true;
			hideTimer.restart();
		}

		function onMutedChanged() {
			root.showSlider = true;
			hideTimer.restart();
		}
	}

    Timer {
		id: hideTimer
		interval: 1500
		onTriggered: root.showSlider = false
	}

    Button {
        id: button

        implicitWidth: indicator.implicitWidth
        implicitHeight: indicator.implicitHeight

        background: Item {}
        indicator: Text {
            id: indicator
            color: (muted) ? "gray" : "white"

            text: {
                if (muted) {return " "}
                if (percent == 0) {return "";}
                if (percent < 0.5) {return "";}
                return " "
            }
        }

        onClicked: {
			root.showSlider = !root.showSlider;
			hideTimer.restart();
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

                HoverHandler {
                    id: popupHover

                }

                Connections {
                    target: popupHover

                    function onHoveredChanged() {
                        if (popupHover.hovered) {
                            hideTimer.stop();
                        } else {
                            root.showSlider = false;
                        }
                    }
                }


                Slider {
                    id: slider

                    value: node.audio.volume
                    onValueChanged: node.audio.volume = value

                    stepSize: 0.05
                    snapMode: Slider.SnapAlways

                    property real effectivePosition: (1 - visualPosition)

                    orientation: Qt.Vertical

                    handle: Item { }
                    background: Rectangle {
                        color: "#130f0e"

                        implicitHeight: 120
                        implicitWidth: 22

                        radius: width/4
                        border.color: (node.audio.muted) ? "gray" : "white"
                        border.pixelAligned: false
                        border.width: 0.4

                        Rectangle {
                            id: handle

                            color: (node.audio.muted) ? "gray" : "white"
                            height: slider.height * slider.effectivePosition
                            width: slider.width
                            anchors.bottom: parent.bottom

                            Text {
                                id: percentText
                                text: Math.round(percent * 100)
                                font.pixelSize: 11
                                width: slider.width
                                horizontalAlignment: Text.AlignHCenter

                                anchors.bottom: handle.bottom
                                states: State {
                                    id: "bottom"
                                    when: slider.effectivePosition < 0.15
                                    PropertyChanges {percentText.color: "white"}

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
}
