import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire
import qs

PanelWindow {
    id: statusPopup
    implicitWidth: 260
    implicitHeight: 260
    mask: Region {} // focus should never be given to this panel

    visible: true
    property string focusedStatus: "volume"

    function show(newFocus: string) {
        focusedStatus = newFocus
        visible = true
        visibleTimer.restart()
    }
    Timer {
        id: visibleTimer
        interval: 1000
        onTriggered: visible = false
    }

    QtObject {
        id: status
        property real rawBrightness
        property real maxBrightness
        property real brightness: rawBrightness / maxBrightness
        onRawBrightnessChanged: statusPopup.show("brightness")

        property PwNode sink: Pipewire.defaultAudioSink
        property real volume: sink.audio.volume
        property bool muted: sink.audio.muted
        onVolumeChanged: statusPopup.show("volume")
    }

    FileView {
        path: "/sys/class/backlight/intel_backlight/brightness"
        watchChanges: true
        onFileChanged: reload()
        onLoaded: status.rawBrightness = Number(text())
    }
    FileView {
        path: "/sys/class/backlight/intel_backlight/max_brightness"
        onLoaded: status.maxBrightness = Number(text())
    }
    PwObjectTracker {
        objects: status.sink ? [status.sink] : []
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.crust
        border.color: Theme.mauve
        border.width: 1
        Text {
            text: `DEBUG: ${focusedStatus} ${status[focusedStatus]}`
            color: Theme.subtext0
        }

        SVGRender {
            property var statusSVGs: ({
                brightness: {
                    path: Qt.resolvedUrl("./brightness.svg"),
                    strokeLength: 4,
                },
                volume: {
                    path: Qt.resolvedUrl("./volume.svg"),
                    strokeLength: 36.307533264160156,
                },
            })

            path: statusSVGs[focusedStatus].path
            strokeLength: statusSVGs[focusedStatus].strokeLength
            strokePercentage: status[focusedStatus]

            size: Qt.size(parent.width * 0.85, parent.width * 0.85)
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                margins: 8
            }
            stroke: Theme.text
        }

        Rectangle {
            id: mainBar
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 16
            }
            implicitHeight: 8
            color: Theme.overlay0
        }
        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 16
                rightMargin: (mainBar.width * (1 - status[focusedStatus])) + 16
            }
            implicitHeight: 8
            color: Theme.mauve
        }
    }
}
