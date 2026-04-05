pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    property var devices: UPower.devices
    property var primary: UPower.displayDevice
}
