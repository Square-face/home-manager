import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    default property alias content: row.data
    property alias anchor: root.anchors

    width: rect.width
    height: 18

    Rectangle {
        id: rect
        color: "#111111"
        radius: 9
        width: row.width + 18
        height: parent.height

        RowLayout {
            id: row
            anchors.centerIn: parent
            height: parent.height
        }
    }
}
