pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSource, Pipewire.defaultAudioSink]
    }

    readonly property var primary_sink: Pipewire.defaultAudioSink
    readonly property var primary_source: Pipewire.defaultAudioSource
}
