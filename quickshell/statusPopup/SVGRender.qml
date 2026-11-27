import QtQuick
import Quickshell.Io

Image {
    id: svg
    required property string path
    required property size size
    property string fill: "none"
    property string stroke: "none"
    property real strokePercentage: 1
    // qt's svg renderer doesnt support pathLength, so we cant force it to be 1 in the svg encodeURIComponent
    // get pathLength using js manually `a.getTotalLength()`
    property real strokeLength: 1000000

    property string raw
    FileView {
        path: svg.path
        onLoaded: svg.raw = text()
    }
    function buildSvg(fill, stroke, strokePercentage, strokeLength) {
        const filled = svg.raw
            .replace(/\$strokeLength/g, strokeLength)
            .replace(/\$dashOffset/g, strokeLength - strokePercentage * strokeLength)
            .replace(/\$fill/g, fill)
            .replace(/\$stroke/g, stroke)
        return "data:image/svg+xml;utf8," + encodeURIComponent(filled);
    }
    sourceSize: svg.size
    smooth: true
    source: buildSvg(svg.fill, svg.stroke, svg.strokePercentage, svg.strokeLength)
}
