import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets

Rectangle {
    id: root

    required property real value;
    required property string icon;
    required property string handleColor;
    required property string backgroundColor;
    signal moved(real value)
    signal clicked()

    color: "transparent"
    // implicitWidth: 35
    // implicitHeight: 150

    Slider {
        id: control
        value: parent.value
        orientation: Qt.Vertical
        onMoved: root.moved(value)

        anchors.bottom: root.bottom

        implicitWidth: root.width
        implicitHeight: root.height

        handle: Item {
            // id: handle
            x: control.leftPadding
            y: control.topPadding + control.visualPosition * (control.availableHeight - height)
            implicitWidth: control.implicitWidth
            implicitHeight: control.implicitWidth
        }

        background: ClippingWrapperRectangle {
            x: control.leftPadding
            y: control.topPadding
            radius: width/2
            color: "transparent"

            Rectangle {
                id: track
                color: backgroundColor

                implicitWidth: control.implicitWidth
                implicitHeight: control.availableHeight

                Rectangle {
                    color: handleColor
                    anchors.bottom: parent.bottom
                    implicitHeight: (1-control.visualPosition) * (parent.implicitHeight - handle.height) + handle.height/2
                    implicitWidth: parent.implicitWidth
                }

                Rectangle {
                    id: handle
                    x: control.leftPadding
                    y: control.topPadding + control.visualPosition * (control.availableHeight - height)
                    implicitWidth: control.implicitWidth
                    implicitHeight: control.implicitWidth
                    radius: width/2

                    color: handleColor

                    Text {
                        anchors.horizontalCenter: handle.horizontalCenter
                        anchors.top: handle.top
                        text: icon
                        property real max: track.width/2 - height/2
                        property real min: height/4

                        anchors.topMargin: {
                            if (value > 0.2) {return max;}

                            return (value*5 * (max - min)) + min;
                        }
                    }
                }

                Text {
                    id: valueText
                    text: Math.round(value * 100) + "%"
                    anchors.bottom: track.bottom
                    anchors.horizontalCenter: track.horizontalCenter

                    property real max: track.width/2 - height/2
                    property real min: height/4

                    anchors.bottomMargin: {
                        if (value > 0.2) {return max;}

                        return (value*5 * (max - min)) + min;
                    }

                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.clicked()
                }
            }
        }
    }
}
