import QtQuick
import Quickshell.Services.Pipewire

Rectangle {
    width: 14
    height: parent.height
    color: "transparent"

    Text {
        anchors.centerIn: parent
        color: "white"
        horizontalAlignment: Text.AlignLeft

        property bool muted: Audio.primary_source?.audio.muted ?? false
        width: (muted) ? 15 : 10 

        text: {
            if (muted) {return ""}
            return ""
        }
    }
}
