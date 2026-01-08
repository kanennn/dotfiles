import QtQuick
import Quickshell
import Quickshell.Hyprland

Row {
    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
        margins: 1
    }

    spacing: 5
    Repeater {
        model: Hyprland.workspaces
        delegate: Rectangle {
            id: space
            radius: 10
            width: Hyprland.focusedWorkspace === modelData ? parent.height * 1.7 : parent.height
            height: parent.height
            color: Hyprland.focusedWorkspace === modelData ? Config.shadow : Config.fog

            transitions: Transition {
                NumberAnimation {
                    target: space
                    property: "width"
                    //easing.type: Easing.InOutQuad
                    duration: 500
                }
            }

            Text {
                anchors.centerIn: parent
                text: modelData.id
                font: Config.f
                color: Hyprland.focusedWorkspace === modelData ? Config.light : Config.shadow
            }
        }
    }
}
