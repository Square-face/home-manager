import Quickshell
import Quickshell.Services.Pipewire
import "audio" as Audio
import "common" as Common

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

            Common.Island {
                anchors.top: parent.top
                anchors.left: parent.left
                ClockWidget { }
            }

            Common.Island {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                ClockWidget { }
            }

            Common.Island {
                id: networking
                anchors.top: parent.top
                anchors.right: audio.left
                anchors.rightMargin: 2
                NetworkWidget {}
            }

            Audio.Island {
                id: audio
                anchors.top: parent.top
                anchors.right: system.left
                anchors.rightMargin: 2
            }

            Common.Island {
                id: system
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 2
                BatteryWidget {}
            }
        }
    }
}
