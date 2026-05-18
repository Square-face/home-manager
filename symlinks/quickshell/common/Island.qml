import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    default property alias content: row.data
    property alias anchor: root.anchors

    implicitWidth: inner.implicitWidth
    height: 18

    Rectangle {
        id: inner
        color: "#111111"
        radius: 9
        implicitWidth: row.implicitWidth + (radius*2)
        height: parent.height

        RowLayout {
            id: row
            anchors.centerIn: parent
            height: parent.height
        }
    }
}
