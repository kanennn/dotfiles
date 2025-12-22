pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property color color: "blue"
    readonly property int edge: 7
    readonly property color light: "#FFFFFF"
    readonly property color shadow: "#666666"
    readonly property color fog: "#EEEEEE"

    readonly property font f: ({
            family: "FiraCodeNerdFont",
            pointSize: 10.5
        })
}
