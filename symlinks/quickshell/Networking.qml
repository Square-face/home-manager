pragma Singleton

import Quickshell
import Quickshell.Networking

Singleton {
    id: root

    property var devices: Networking.devices
    property var connectivity: Networking.connectivity
}
