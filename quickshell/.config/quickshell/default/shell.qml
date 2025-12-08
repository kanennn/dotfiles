import Quickshell
import QtQuick
import QtQuick.Effects
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

ShellRoot {
    property int edge: 7
    property color light: "#FFFFFF"
    property color shadow: "#666666"
    property color fog: "#EEEEEE"

    readonly property font f: ({
            family: "FiraCodeNerdFont",
            pointSize: 10.5
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

                color: light

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
        color: light

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
                implicitWidth: 184 + 3 * edge
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
                        id: space
                        radius: 10
                        width: Hyprland.focusedWorkspace === modelData ? parent.height * 1.7 : parent.height
                        height: parent.height
                        color: Hyprland.focusedWorkspace === modelData ? shadow : fog

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
                            font: f
                            color: Hyprland.focusedWorkspace === modelData ? light : shadow
                        }
                    }
                }
            }

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
                color: fog

                Repeater {
                    model: Mpris.players
                    delegate: Text {
                        id: innerMusic
                        font: f
                        text: modelData.trackTitle
                        color: shadow
                        anchors.centerIn: parent
                    }
                }
            }

            // RIGHT SIDE
            Row {
                anchors {
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    rightMargin: 10
                }
                spacing: 10

                //PIPEWIRE
                Rectangle {
                    // this code is so spaghetti
                    id: handler
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        margins: 1
                    }
                    property PwNode thing: Pipewire.defaultAudioSink
                    PwObjectTracker {
                        objects: [handler.thing]
                    }
                    //anchors.leftMargin: 10
                    radius: 7
                    width: pipewireText.implicitWidth + 5 * time.anchors.margins

                    height: parent.height
                    color: fog
                    Text {
                        id: pipewireText
                        anchors.centerIn: parent
                        font: f
                        text: parent.thing.nickname + " " + Math.round(parent.thing.audio.volume * 100) + "%"
                        color: shadow
                    }
                }

                // BATTERY
                Rectangle {
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        margins: 1
                    }
                    //anchors.leftMargin: 10
                    radius: 7
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
                Rectangle {
                    MouseArea {
                        id: clockarea
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                    anchors {
                        margins: 1
                        top: parent.top
                        bottom: parent.bottom
                    }
                    //anchors.rightMargin: 10 + 1
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
            }

            // CLOCK
            SystemClock {
                id: clock
                precision: SystemClock.Seconds
            }

            // WINDOW
            Rectangle {
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: notch.left
                    margins: 1
                }
                visible: true
                radius: 12
                width: innerText.width + 20
                color: fog

                Text {
                    id: innerText
                    font: f
                    text: ToplevelManager.activeToplevel.appId
                    color: shadow
                    anchors.centerIn: parent
                }
            }
        }
    }
}
