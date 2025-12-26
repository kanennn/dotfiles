import QtQuick
import Quickshell
import Quickshell.Services.Mpris

// This needs mega improving lol
Rectangle {
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: notch.right
        margins: 1
    }
    visible: true
    radius: 12
    width: 160
    color: Config.fog

    Repeater {
        model: Mpris.players
        delegate: Text {
            id: innerMusic
            font: Config.f
            text: modelData.trackTitle
            color: Config.shadow
            anchors.centerIn: parent
        }
    }
}
