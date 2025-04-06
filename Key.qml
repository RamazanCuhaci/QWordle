import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: keyButton
    property string letter: ""
    property int state: 0
    property color inColor : "#818384"


    text: letter
    width: 30
    height: 30
    font.bold: true

    background: Rectangle {
        anchors.fill: parent
        radius: 5
        border.color: "#565758"
        border.width: 1
        color: inColor
    }

    onPressed: {
        wordleGame.typeLetter(letter)
    }

    onStateChanged: {
        if (state === 1) {        // Correct state
            inColor = "#538d4e";
        } else if (state === 2) { // Misplaced state
            inColor = "#b59f3b";
        } else if (state === 3) { // Incorrect state
            inColor = "#3a3a3c";
        }
    }

}
