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
        onStarted: collapsing.stop()
        onFinished: () => {
            closeTimer.interval = 1300;
            closeTimer.restart();
        }

        PropertyAnimation {target: loader; property: "sourceComponent"; to: popup; duration: 0; }
        PropertyAnimation {target: inner; property: "visible"; to: false; duration: 0; }

        PropertyAnimation {target: inner; property: "implicitWidth"; from: normalWidth; to: expandedWidth; duration: 750; easing.type: Easing.OutBack}
        PropertyAnimation {target: root; property: "implicitWidth"; from: normalWidth; to: expandedWidth; duration: 750; easing.type: Easing.OutBack}
        PropertyAnimation {target: root; property: "width"; from: normalWidth; to: expandedWidth; duration: 750; easing.type: Easing.OutBack}

        PropertyAnimation {target: root; property: "implicitHeight"; from: normalHeight; to: expandedHeight; duration: 750; easing.type: Easing.OutBack}
    }

    SequentialAnimation {
        id: collapsing
        running: false
        onStarted: expanding.stop()
        
        PropertyAnimation {target: inner; property: "visible"; to: true; duration: 0; }
        ParallelAnimation {
            PropertyAnimation {target: inner; property: "implicitWidth"; to: normalWidth; from: expandedWidth; duration: 350; easing.type: Easing.OutQuad}
            PropertyAnimation {target: root; property: "implicitWidth"; to: normalWidth; from: expandedWidth; duration: 350; easing.type: Easing.OutQuad}
            PropertyAnimation {target: root; property: "width"; to: normalWidth; from: expandedWidth; duration: 350; easing.type: Easing.OutQuad}

            PropertyAnimation {target: root; property: "implicitHeight"; to: normalHeight; from: expandedHeight; duration: 500; easing.type: Easing.InBack}
        }
        PropertyAnimation {target: loader; property: "sourceComponent"; to: null; duration: 0; }
    }

    Loader {
        id: loader
        width: inner.implicitWidth
    }

    Rectangle {
        id: inner
        color: "#000000"
        radius: 9
        width: root.width
        height: root.height

        MouseArea {
            anchors.fill: parent
            onClicked: expanding.start()
        }

        Indicator {id: row}
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
                            if (expanding.running) { return; }

                            if (hoverArea.hovered) {
                                allowClose = false;
                                closeTimer.stop();
                                return;
                            }

                            allowClose = true;
                            closeTimer.interval = 700;
                            closeTimer.start();
                        }
                    }

                    Widget{}
                }
            }
        }
    }
}

