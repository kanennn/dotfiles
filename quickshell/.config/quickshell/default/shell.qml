import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import Quickshell.Services.UPower

ShellRoot {
    property int edge: 7
    property color light: "#FFFFFF"
    property color shadow: "#666666"
    property color fog: "#EEEEEE"

    readonly property font f: ({
            family: "FiraCodeNerdFont",
            pointSize: 12
        })
    readonly property font fs: ({
            family: "FiraCodeNerdFont",
            pointSize: 10
        })

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
            anchors.leftMargin: 3 * edge
            anchors.rightMargin: 3 * edge

            Item {
                id: notch
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    top: parent.top
                }
                implicitWidth: 184
            }

            // Workspaces
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
                        radius: 10
                        width: Hyprland.focusedWorkspace === modelData ? parent.height * 1.7 : parent.height
                        height: parent.height
                        color: Hyprland.focusedWorkspace === modelData ? shadow : fog

                        Text {
                            anchors.centerIn: parent
                            text: modelData.id
                            font: fs
                            color: Hyprland.focusedWorkspace === modelData ? light : shadow
                        }
                    }
                }
            }

            // BATTERY
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
                color: fog
                Text {
                    anchors.centerIn: parent
                    font: f
                    text: Math.round(UPower.displayDevice.percentage * 100) + "%"
                    color: shadow
                }
            }

            // CLOCK
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
                radius: 7
                implicitWidth: time.implicitWidth + 5 * time.anchors.margins
                height: parent.height
                color: fog
                Text {
                    id: time
                    anchors.margins: 3
                    anchors.centerIn: parent
                    font: f
                    text: clockarea.containsMouse ? Qt.formatDateTime(clock.date, "hh:mm:ss") : Qt.formatDateTime(clock.date, "hh:mm")
                    color: shadow
                }
            }

            // WINDOW
            Rectangle {
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: notch.left
                }
                anchors.rightMargin: 10
                radius: 12
                width: innerText.width + 20
                color: fog

                Text {
                    id: innerText
                    font: f
                    text: Hyprland.activeToplevel.title
                    color: shadow
                    anchors.centerIn: parent
                }
            }
        }
    }
}
