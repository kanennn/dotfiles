import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import Quickshell.Services.UPower

ShellRoot {
    property int edge: 7
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
                    anchors.topMargin: edge
                    anchors.leftMargin: edge
                    anchors.rightMargin: edge
                    anchors.bottomMargin: edge

                    radius: 30
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

        Item {
            id: barlayout
            anchors.fill: parent
            anchors.topMargin: edge
            anchors.leftMargin: 2 * edge
            anchors.rightMargin: 2 * edge
            //spacing: 10

            Item {
                id: notch
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    top: parent.top
                }
                implicitWidth: 184
            }
            Row {
                spacing: 5
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                anchors.leftMargin: 5
                Repeater {
                    model: Hyprland.workspaces
                    delegate: Rectangle {
                        radius: 12
                        width: Hyprland.focusedWorkspace === modelData ? 40 : 20
                        height: parent.height
                        color: Hyprland.focusedWorkspace === modelData ? "tomato" : "lightpink"

                        Text {
                            anchors.centerIn: parent
                            text: modelData.id
                            color: "white"
                        }
                    }
                }
            }
            Rectangle {
                anchors {
                    left: notch.right
                    top: parent.top
                    bottom: parent.bottom
                }
                anchors.leftMargin: 10
                radius: 12
                width: 50
                height: parent.height
                color: "pink"
                Text {
                    anchors.centerIn: parent
                    text: Math.round(UPower.displayDevice.percentage * 100) + "%"
                    color: "white"
                }
            }
            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }
            Rectangle {
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                MouseArea {
                    id: clockarea
                    anchors.fill: parent
                    hoverEnabled: true
                }
                anchors.rightMargin: 10
                radius: 12
                width: 70
                height: parent.height
                color: "pink"
                Text {
                    anchors.centerIn: parent
                    text: clockarea.containsMouse ? Qt.formatDateTime(clock.date, "hh:mm:ss") : Qt.formatDateTime(clock.date, "hh:mm")
                    color: "white"
                }
            }

            Rectangle {
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: notch.left
                }
                anchors.rightMargin: 10
                radius: 12
                width: innerText.width + 20
                color: "tomato"

                Text {
                    id: innerText
                    text: Hyprland.activeToplevel.title
                    color: main
                    anchors.centerIn: parent
                }
            }
        }
    }
}
