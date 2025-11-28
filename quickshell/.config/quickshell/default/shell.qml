import Quickshell
import QtQuick.Layouts
import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland

ShellRoot {

    property color main: "#FFFFFF"
    property color next: "#AAAAAA"

    PanelWindow {
        id: root
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

                color: main

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
                    anchors.topMargin: 10
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.bottomMargin: 10

                    radius: 18
                }
            }
        }
    }

    PanelWindow {
        id: bar
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 32
        color: main

        RowLayout {
            id: right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 20
            spacing: 10

            Repeater {
                model: 10
                Rectangle {
                    width: 10
                    height: 10
                    color: next
                }
            }
        }

        RowLayout {
            id: left
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            spacing: 10

            Repeater {
                model: 10
                Rectangle {
                    width: 10
                    height: 10
                    color: next
                }
            }
        }
    }
}
