import QtQuick
import Quickshell.Networking

Row {
    anchors.centerIn: parent
    height: parent.height
    spacing: 5
    Repeater {
        model: Networking.devices

        Text {
            required property NetworkDevice modelData
            color: (modelData.connected) ? "white" : "#AAAAAA"
            text: {
                if (modelData.type == DeviceType.Wifi) {
                    switch (modelData.state) {
                        case ConnectionState.Unknown: return "󱚼"
                        case ConnectionState.Connected: return "󰖩"
                        case ConnectionState.Connecting: return "󱛇"
                        case ConnectionState.Disconnected: return "󰖪"
                        case ConnectionState.Disconnecting: return "󱛅"
                    }
                }

                if (modelData.type == DeviceType.Wired) {
                    switch (modelData.state) {
                        case ConnectionState.Unknown: return "󰈀"
                        case ConnectionState.Connected: return ""
                        case ConnectionState.Connecting: return ""
                        case ConnectionState.Disconnected: return "󰈀"
                        case ConnectionState.Disconnecting: return ""
                    }
                }

                return modelData.type + modelData.state
            }
        }
    }
}
