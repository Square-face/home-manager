import Quickshell
import Quickshell.Services.Pipewire
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    property alias anchor: root.anchors
    readonly property int fullWidth: 100 
    property bool allowClose: true
    property bool expanded: !inner.visible

    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    PwObjectTracker { objects: [ sink, source ] }

    Connections {
        target: sink?.audio ?? null
        function onVolumeChanged() {
            closeTimer.interval = 1300;
            closeTimer.restart();
            if (!expanded) { expanding.start(); }
        }
        function onMutedChanged() {
            closeTimer.interval = 1300;
            closeTimer.restart();
            if (!expanded) {
                expanding.start();
            }
        }
    }

    Connections {
        target: source?.audio ?? null
        function onVolumeChanged() {
            closeTimer.interval = 1300;
            closeTimer.restart();
            if (!expanded) { expanding.start();}
        }

        function onMutedChanged() {
            closeTimer.interval = 1300;
            closeTimer.restart();
            if (!expanded) { expanding.start();}
        }
    }

    Timer {
        id: closeTimer
        running: false
        interval: 1300
        onTriggered: if (allowClose) {collapsing.start();}
    }

    property real normalWidth: row.implicitWidth + (inner.radius*2)
    property real expandedWidth: 100

    property real normalHeight: 18
    property real expandedHeight: 200

    implicitWidth: normalWidth
    implicitHeight: normalHeight

    ParallelAnimation {
        id: expanding
        running: false

        PropertyAnimation {target: loader; property: "sourceComponent"; to: popup; duration: 0; }
        PropertyAnimation {target: inner; property: "visible"; to: false; duration: 0; }

        PropertyAnimation {target: inner; property: "implicitWidth"; from: normalWidth; to: expandedWidth; duration: 150; easing.type: Easing.OutQuad}
        PropertyAnimation {target: root; property: "implicitWidth"; from: normalWidth; to: expandedWidth; duration: 150; easing.type: Easing.OutQuad}

        PropertyAnimation {target: root; property: "implicitHeight"; from: normalHeight; to: expandedHeight; duration: 150; easing.type: Easing.OutQuad}

        onStarted: collapsing.stop()
        onFinished: () => {
            closeTimer.interval = 1300;
            closeTimer.restart();
        }
    }

    SequentialAnimation {
        id: collapsing
        running: false
        ParallelAnimation {
            PropertyAnimation {target: inner; property: "visible"; to: true; duration: 0; }

            PropertyAnimation {target: inner; property: "implicitWidth"; to: normalWidth; from: expandedWidth; duration: 150; easing.type: Easing.OutQuad}
            PropertyAnimation {target: root; property: "implicitWidth"; to: normalWidth; from: expandedWidth; duration: 150; easing.type: Easing.OutQuad}

            PropertyAnimation {target: root; property: "implicitHeight"; to: normalHeight; from: expandedHeight; duration: 150; easing.type: Easing.OutQuad}
        }

        PropertyAnimation {target: loader; property: "sourceComponent"; to: null; duration: 0; }

        onStarted: expanding.stop()
    }

    Loader {
        id: loader
        width: inner.implicitWidth
    }

    Rectangle {
        id: inner
        color: "#111111"
        radius: 9
        width: root.width
        height: root.height

        MouseArea {
            anchors.fill: parent
            onClicked: expanding.start()
        }

        RowLayout {
            id: row
            anchors.centerIn: parent
            height: parent.height
            Speaker { node: (expanded) ? null : sink }
            Microphone { node: (expanded) ? null : source }
        }
    }

    Component {
        id: popup
        Item {

            PopupWindow {
                id: popupWindow
                anchor.item: loader
                anchor.edges: Edges.Right | Edges.Top
                anchor.gravity: Edges.Left | Edges.Bottom

                implicitWidth: root.implicitWidth
                implicitHeight: root.implicitHeight

                color: "transparent"
                visible: true

                Rectangle {
                    color: "#111111"
                    radius: 15
                    anchors.fill: parent
                    MouseArea {
                        id: closeArea
                        anchors.fill: parent
                        onClicked: collapsing.start()
                    }

                    HoverHandler {
                        id: hoverArea
                    }

                    Connections {
                        target: expanding
                        function onFinished() {
                            allowClose = !hoverArea.hovered;
                        }
                    }

                    Connections {
                        target: hoverArea
                        function onHoveredChanged() {
                            if (expanding.running) {return;}

                            if (hoverArea.hovered) {
                                allowClose = false;
                                closeTimer.stop();
                                return;
                            }

                            allowClose = true;
                            closeTimer.interval = 300;
                            closeTimer.start();
                        }
                    }

                    Widget{}
                }
            }
        }
    }
}

