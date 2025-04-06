import QtQuick 2.15

Item {
    id: letterCell
    width: board.cellWidth
    height: board.cellHeight

    property string letter
    property int state
    property color inColor: "#121213"
    property color borderColor: letter === " " ? "#353536" : "#565758"
    property real originalHeight: board.cellHeight

    // Rectangle representing the key
    Rectangle {
        id: cell
        width: parent.width - 5
        height: letterCell.originalHeight - 5  // Start with the original height
        border.color: letterCell.borderColor
        border.width: 2
        anchors.centerIn: parent  // Ensure Rectangle is centered in parent

        color: letterCell.inColor

    }

    // Text inside the Rectangle
    Text {
        id: letterText
        text: letterCell.letter
        font.pixelSize: 30
        font.bold: true
        color: "#f8f8f8"
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // Trigger shrink and grow animation when letter changes
    onLetterChanged: {
        if (letter !== " ") {
            typeAnimation.start();  // Start shrink-grow animation for the entire Item
        }
    }

    // Update colors based on state
    onStateChanged: {
        if (state === 1) {  // Correct state
            inColor = "#538d4e";
            borderColor = "#538d4e";
        } else if (state === 2) {  // Misplaced state
            inColor = "#b59f3b";
            borderColor = "#b59f3b";
        } else if (state === 3) {  // Incorrect state
            inColor = "#3a3a3c";
            borderColor = "#3a3a3c";
        }
    }

    // Sequential animation for typing effect (Scale)
    SequentialAnimation {
        id: typeAnimation
        ScaleAnimator { target: cell; to: 1.2; duration: 120; easing.type: Easing.OutQuad }
        ScaleAnimator { target: cell; to: 1.0; duration: 120; easing.type: Easing.InQuad }
    }

    // Shrink and grow animation (shrinks to 0 height and grows back)
    SequentialAnimation {
        id: shrinkGrowAnimationo
        PropertyAnimation {
            target: letterCell
            property: "height"
            from: letterCell.originalHeight
            to: 0
            duration: 200
            easing.type: Easing.InQuad
        }
        PropertyAnimation {
            target: letterCell
            property: "height"
            from: 0
            to: letterCell.originalHeight
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    // Shrink and grow animation for the entire Item
    SequentialAnimation {
        id: revealAnimation
        PropertyAnimation {
            target: cell
            property: "height"
            from: 55
            to: 0
            duration: 200
            easing.type: Easing.InQuad
        }
        PropertyAnimation {
            target: cell
            property: "height"
            from: 0
            to: 55
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    function triggerRevealAnimation(delay) {
        console.log("RevealAnimation called with delay:", delay);
        delayedStartTimer.interval = delay;
        delayedStartTimer.start();
    }

    Timer {
        id: delayedStartTimer
        interval: 0
        repeat: false
        onTriggered: revealAnimation.start()
    }
}
