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

    implicitWidth: loader.width
    implicitHeight: 18

    SequentialAnimation {
        id: expanding
        running: false
        PropertyAnimation { target: loader; property: "sourceComponent"; to: popup; duration: 0 }
        PropertyAnimation { target: inner; property: "visible"; to: false; duration: 0 }
        ParallelAnimation {
            PropertyAnimation { target: loader; property: "width"; to: fullWidth; easing.type: Easing.InOutQuad; duration: 300 }
            PropertyAnimation { target: inner; property: "implicitWidth"; to: fullWidth; easing.type: Easing.InOutQuad; duration: 300 }
            PropertyAnimation { target: root; property: "implicitHeight"; to: 200; easing.type: Easing.InOutCirc; duration: 300 }
        }
        onStarted: collapsing.stop()
        onFinished: () => {
            closeTimer.interval=1300;
            closeTimer.restart();
        }
    }

    SequentialAnimation {
        id: collapsing
        running: false
        PropertyAnimation { target: inner; property: "visible"; to: true; duration: 0 }

        ParallelAnimation {
            PropertyAnimation { target: loader; property: "width"; to: inner.implicitWidth; easing.type: Easing.InOutQuad; duration: 100 }
            PropertyAnimation { target: root; property: "implicitHeight"; to: 18; easing.type: Easing.InOutQuad; duration: 100 }
            PropertyAnimation { target: inner; property: "implicitWidth"; to: row.implicitWidth + (inner.radius*2); easing.type: Easing.InOutQuad; duration: 100 }
        }
        PropertyAnimation { target: loader; property: "sourceComponent"; to: null; duration: 0 }

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
        implicitWidth: row.implicitWidth + (radius*2)
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
            Connections {
                target: popupWindow ?? null
                function onVisibleChanged() {
                    if (popupWindow.visible) {return;}
                    collapsing.start()
                }
            }

            PopupWindow {
                id: popupWindow
                anchor.item: loader
                anchor.edges: Edges.Right | Edges.Top
                anchor.gravity: Edges.Left | Edges.Bottom

                implicitWidth: loader.width
                implicitHeight: root.height

                grabFocus: false

                color: "transparent"
                visible: true


                Rectangle {
                    color: "#111111"
                    radius: 9
                    anchors.fill: parent
                    border {
                        color: "#505050"
                        width: 0.5
                        pixelAligned: false
                    }
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

