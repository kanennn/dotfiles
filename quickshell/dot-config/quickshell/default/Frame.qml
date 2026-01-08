import QtQuick
import Quickshell 

Variants {
    model: Quickshell.screens

    Scope {
        id: scope
        required property ShellScreen modelData

        Outline { monitor: modelData}
        Bar { monitor: modelData }
    }
}
