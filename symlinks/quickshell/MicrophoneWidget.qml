import QtQuick
import Quickshell.Services.Pipewire

Rectangle {
    width: 11
    height: parent.height
    color: "transparent"

    Text {
        anchors.centerIn: parent
        color: muted ? "#AAAAAA" : "white"
        horizontalAlignment: Text.AlignLeft

        property bool muted: Audio.primary_source?.audio.muted

        text: {
            if (muted) {return ""}
            return ""
        }
    }
}
