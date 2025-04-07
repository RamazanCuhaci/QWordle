import QtQuick 2.15

Rectangle {
    id: keyRect
    property string letter: ""
    property int state: 0
    property color defaultColor: "#818384"
    property color hoverColor: "#9a9fa1"
    property color currentColor: defaultColor
    width: 30
    height: 40
    radius: 5
    color: currentColor

    Text {
        anchors.centerIn: parent
        text: letter
        font.bold: true
        color: "white"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPressed: wordleGame.typeLetter(letter)

        onEntered: keyRect.currentColor = hoverColor
        onExited: keyRect.currentColor = keyRect.getColorForState()
    }

    function getColorForState() {
        if (state === 1) {
            return "#538d4e"; // correct
        } else if (state === 2) {
            return "#b59f3b"; // present
        } else if (state === 3) {
            return "#3a3a3c"; // absent
        } else {
            return defaultColor;
        }
    }

    Component.onCompleted: currentColor = getColorForState()
    onStateChanged: currentColor = getColorForState()
}
