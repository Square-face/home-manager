import QtQuick
import Quickshell.Services.Pipewire

Text {
    id: root
    color: "white"

    property real percent: Audio.primary_sink?.audio.volume
    property bool muted: Audio.primary_sink?.audio.muted

    text: {
        if (muted) {return " "}
        if (percent == 0) {return "";}
        if (percent < 0.5) {return "";}
        return " "
    }
}
