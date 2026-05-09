import QtQuick
import Quickshell.Services.Pipewire

Rectangle {
    width: 11
    height: parent.height
    color: "transparent"

    property bool muted: Audio.primary_source?.audio.muted

    Text {
        anchors.centerIn: parent
        color: muted ? "#AAAAAA" : "white"
        horizontalAlignment: Text.AlignLeft


        text: (muted) ? "" : ""
    }
}
