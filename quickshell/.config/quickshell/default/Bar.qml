import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Services.Mpris
import Quickshell.Services.Pipewire

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 32
    color: Config.light

    Item {
        anchors.fill: parent
        anchors.topMargin: Config.edge
        anchors.leftMargin: 3 * Config.edge
        anchors.rightMargin: 3 * Config.edge

        Item {
            id: notch
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                top: parent.top
            }
            implicitWidth: 184 + 3 * Config.edge
        }

        // Workspaces
        //
        Workspaces {}

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
                color: Config.fog
                Text {
                    id: pipewireText
                    anchors.centerIn: parent
                    font: Config.f
                    text: parent.thing.nickname + " " + Math.round(parent.thing.audio.volume * 100) + "%"
                    color: Config.shadow
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
                color: Config.fog
                Text {
                    anchors.centerIn: parent
                    font: Config.f
                    text: Math.round(UPower.displayDevice.percentage * 100) + "%"
                    color: Config.shadow
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
                color: Config.fog
                Text {
                    id: time
                    anchors.margins: 3
                    anchors.centerIn: parent
                    font: Config.f
                    text: clockarea.containsMouse ? Qt.formatDateTime(clock.date, "hh:mm:ss") : Qt.formatDateTime(clock.date, "hh:mm")
                    color: Config.shadow
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
            color: Config.fog

            Text {
                id: innerText
                font: Config.f
                text: ToplevelManager.activeToplevel.appId
                color: Config.shadow
                anchors.centerIn: parent
            }
        }
    }
}
