import QtQuick
import Quickshell
import QtQuick.Effects

PanelWindow {
    id: root
    required property ShellScreen monitor
    screen: monitor
    color: "transparent"
    visible: true
    // WlrLayershell.layer: WlrLayer.Top

    mask: Region {
        item: container
        intersection: Intersection.Xor
    }

    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }

    Item {
        id: container
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent

            color: Config.light

            layer.enabled: true

            layer.effect: MultiEffect {
                maskSource: mask
                maskEnabled: true
                maskInverted: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1
            }
        }

        Item {
            id: mask

            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill: parent
                anchors.topMargin: Config.edge
                anchors.leftMargin: Config.edge
                anchors.rightMargin: Config.edge
                anchors.bottomMargin: Config.edge

                radius: 30
            }
        }
    }
}
