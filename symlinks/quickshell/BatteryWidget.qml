import QtQuick
import Quickshell.Services.UPower


Rectangle {
    width: 13
    height: parent.height
    visible: primary.ready & primary.isLaptopBattery
    color: "transparent"

    property UPowerDevice primary: UPower.displayDevice
    property real prc: primary.percentage ?? 0

    Text {
        id: indicator
        color: "white"
        font.pixelSize: 14

        transform: Rotation { origin.x: 6; origin.y: 11; angle: 90 }


        text: {
            if (prc < 0.075) {return "󰂎";}
            if (prc < 0.150) {return "󰁺";}
            if (prc < 0.225) {return "󰁻";}
            if (prc < 0.300) {return "󰁼";}
            if (prc < 0.375) {return "󰁽";}
            if (prc < 0.450) {return "󰁾";}
            if (prc < 0.525) {return "󰁿";}
            if (prc < 0.600) {return "󰂀";}
            if (prc < 0.675) {return "󰂁";}
            if (prc < 0.750) {return "󰂂";}

            return "󰁹"
        }
    }
}
