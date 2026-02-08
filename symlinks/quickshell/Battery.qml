pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    property var batteries: UPower.values
}
