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
    
    Text {
        id: valueText
        text: Math.round(value * 100) + "%"
        color: "white"
        anchors.top: root.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: root.horizontalCenter
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
        }
    }

    Slider {
        id: control
        value: parent.value
        orientation: Qt.Vertical
        onMoved: root.moved(value)

        anchors.bottom: root.bottom

        implicitWidth: root.width
        implicitHeight: root.height - valueText.implicitHeight - valueText.anchors.bottomMargin

        handle: Rectangle {
            id: handle
            x: control.leftPadding
            y: control.topPadding + control.visualPosition * (control.availableHeight - height)
            implicitWidth: control.implicitWidth
            implicitHeight: control.implicitWidth
            radius: width/2

            color: handleColor

            Text {
                anchors.horizontalCenter: handle.horizontalCenter
                anchors.verticalCenter: handle.verticalCenter
                text: icon
            }
        }

        background: ClippingWrapperRectangle {
            x: control.leftPadding
            y: control.topPadding
            radius: width/2
            color: "transparent"

            Rectangle {
                color: backgroundColor

                implicitWidth: control.implicitWidth
                implicitHeight: control.availableHeight

                Rectangle {
                    color: handleColor
                    anchors.bottom: parent.bottom
                    implicitHeight: (1-control.visualPosition) * (parent.implicitHeight - handle.height) + handle.height/2
                    implicitWidth: parent.implicitWidth
                }
            }
        }
    }
}
