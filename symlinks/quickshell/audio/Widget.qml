import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import Quickshell.Widgets
import Quickshell.Services.Pipewire
import "../common" as Common

RowLayout {
    id: root
    anchors.fill: parent
    anchors.margins: 7
    spacing: 7

    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource

    PwObjectTracker{ objects: [source, sink] }

    Common.Slider {
        id: sinkSlider
        property real volume: sink?.audio.volume ?? 0
        property bool muted: sink?.audio.muted ?? false

        value: volume
        handleColor: {
            if (muted && volume<=1) {return "#A0A0A0"; }
            if (muted && volume>1) {return "#FFA0A0"; }

            if (!muted && volume<=1) {return "#FFFFFF"; }
            if (!muted && volume>1) {return "#FF5050"; }
            return "#FFFFFF"
        }
        backgroundColor: "#222222"

        icon: {
            if (sink.audio.muted) { return ""; }
            if (value == 0) {return "";}
            if (value < 0.5) {return "";}
            return ""
        }

        onMoved: (value) => sink.audio.volume = value;
        onClicked: () => sink.audio.muted = !sink.audio.muted;

        Layout.fillHeight: true;
        Layout.fillWidth: true;
    }

    Common.Slider {
        id: sourceSlider

        value: source?.audio.volume ?? 0
        handleColor: (source.audio.muted) ? "#A0A0A0" : "#FFFFFF"
        backgroundColor: "#222222"

        icon: {
            if (source.audio.muted) { return ""; }
            return ""
        }

        onMoved: (value) => source.audio.volume = value;
        onClicked: () => source.audio.muted = !source.audio.muted;

        Layout.fillHeight: true;
        Layout.fillWidth: true;
    }
}
