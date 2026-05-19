import QtQuick
import Quickshell.Services.Pipewire

Rectangle {
    width: 11
    height: parent.height
    color: "transparent"

    required property PwNode node;
    visible: node != null

    Text {
        anchors.centerIn: parent
        color: node?.audio.muted ? "#AAAAAA" : "white"
        horizontalAlignment: Text.AlignLeft

        text: (node?.audio.muted) ? "" : ""
    }
}
