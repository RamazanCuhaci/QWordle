import QtQuick 2.15

Item {

    property string letter
    property int state
    property color inColor : "#121213"
    property color borderColor :"#3a3a3c"

    Rectangle {
        id : cell
        width: board.cellWidth - 5
        height: board.cellHeight - 5
        border.color: letter === " " ? "#353536" : "#565758"
        border.width: 2
        anchors.margins: 5
        color: inColor

        Text {
            text: letter
            font.pixelSize: 30
            font.bold: true
            color: "#f8f8f8"
            anchors.centerIn: parent

        }

    }
    // Animation for typing effect
    SequentialAnimation {
        id: typeAnimation
        ScaleAnimator { target: cell; to: 1.2; duration: 100; easing.type: Easing.OutQuad }
        ScaleAnimator { target: cell; to: 1.0; duration: 100; easing.type: Easing.InQuad }
    }

    onLetterChanged: {
        console.log("Letter typed:", letter);
        if (letter !== " ") {
            typeAnimation.start();
        }
    }

    onStateChanged: {

        if (state === 1) {        // Correct state
            inColor = "#538d4e";
        } else if (state === 2) { // Misplaced state
            inColor = "#b59f3b";
        } else if (state === 3) { // Incorrect state
            inColor = "#3a3a3c";
        } else {                  // Empty state
            inColor = "#121213";
        }
    }
}
