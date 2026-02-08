import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    id: root
    default property alias content: row.data
    property alias anchor: root.anchors

    width: rect.width

    Rectangle {
        id: rect
        color: "#111111"
        radius: 9
        width: row.width + 18
        height: 18

        RowLayout {
            id: row
            anchors.centerIn: parent
            width: childrenRect.width
            height: 18
        }
    }
}
