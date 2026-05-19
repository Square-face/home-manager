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

    visible: node != null

    property real percent: node?.audio.volume ?? 0
    property bool muted: node?.audio.muted ?? false

    Text {
        id: indicator
        color: (!muted) ? "white" : "gray"

        text: {
            if (muted) {return ""}
            if (percent == 0) {return "";}
            if (percent < 0.5) {return "";}
            return ""
        }
    }
}
