pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property int edge: 7
    readonly property color shadow: "#CCCCCC"
    readonly property color fog: "#202020"
    readonly property color light: "#110d0b"
    readonly property string mainMonitor: "eDP-1"

    readonly property font f: ({
            family: "FiraCodeNerdFont",
            pointSize: 10.5
        })
}
