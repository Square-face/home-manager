import Quickshell
import Quickshell.Services.Pipewire

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property ShellScreen modelData
            screen: modelData

            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 18

            Island {
                anchors.top: parent.top
                anchors.left: parent.left
                ClockWidget { }
            }

            Island {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                ClockWidget { }
            }

            Island {
                anchors.top: parent.top
                anchors.right: rightmost.left
                anchors.rightMargin: 5
                NetworkWidget {}
            }

            Island {
                id: rightmost
                anchors.top: parent.top
                anchors.right: parent.right
                SpeakerWidget {node: Pipewire.defaultAudioSink}
                MicrophoneWidget {}
                BatteryWidget {}
            }
        }
    }
}
