import QtQuick 2.15

Item {
    id: letterCell
    width: board.cellWidth-5
    height: board.cellHeight-5

    property string letter
    property int state
    property color inColor: "#121213"
    property color borderColor: letter === " " ? "#353536" : "#565758"

    signal revealAnimationFinished()
    signal winAnimationFinished()

    // Combined position transform (used for shake & win)
    transform: [
        Scale {
            id: scaleTransform
            origin.x: width / 2
            origin.y: height / 2
            xScale: 1.0
            yScale: 1.0
        },
        Translate {
            id: positionTransform
            x: 0
            y: 0
        }
    ]

    Rectangle {
        id: cell
        anchors.fill: parent
        border.color: letterCell.borderColor
        border.width: 2
        color: letterCell.inColor

        Text {
            id: letterText
            anchors.centerIn: parent
            text: letterCell.letter
            font.pixelSize: 30
            font.bold: true
            color: "#f8f8f8"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // Typing bounce animation
    onLetterChanged: {
        if (letter !== " ") {
            typeAnimation.start();
        }
    }

    SequentialAnimation {
        id: typeAnimation
        PropertyAnimation { target: cell; property: "scale"; to: 1.2; duration: 100 }
        PropertyAnimation { target: cell; property: "scale"; to: 1.0; duration: 100 }
    }

    // Shake animation
    SequentialAnimation {
        id: notInWordListAnimation
        PropertyAnimation { target: positionTransform; property: "x"; to: -10; duration: 60 }
        PropertyAnimation { target: positionTransform; property: "x"; to: 10; duration: 60 }
        PropertyAnimation { target: positionTransform; property: "x"; to: -6; duration: 40 }
        PropertyAnimation { target: positionTransform; property: "x"; to: 6; duration: 40 }
        PropertyAnimation { target: positionTransform; property: "x"; to: 0; duration: 30 }
    }

    // Flip reveal animation
    SequentialAnimation {
        id: revealAnimation
        PropertyAnimation {
            target: scaleTransform
            property: "yScale"
            from: 1.0
            to: 0.0
            duration: 180
            easing.type: Easing.InQuad
        }
        ScriptAction { script: applyStateColor(state) }
        PropertyAnimation {
            target: scaleTransform
            property: "yScale"
            from: 0.0
            to: 1.0
            duration: 180
            easing.type: Easing.OutQuad
        }
        onFinished: revealAnimationFinished()
    }

    // Win bounce animation
    SequentialAnimation {
        id: winAnimation
        PropertyAnimation {
            target: positionTransform
            property: "y"
            from: 0
            to: -20
            duration: 150
            easing.type: Easing.OutQuad
        }
        PropertyAnimation {
            target: positionTransform
            property: "y"
            from: -20
            to: 0
            duration: 200
            easing.type: Easing.OutBounce
        }
        onFinished: winAnimationFinished()
    }


    function applyStateColor(newState) {
        if (newState === 1) {
            inColor = "#538d4e";
            borderColor = "#538d4e";
        } else if (newState === 2) {
            inColor = "#b59f3b";
            borderColor = "#b59f3b";
        } else if (newState === 3) {
            inColor = "#3a3a3c";
            borderColor = "#3a3a3c";
        }
    }

    function triggerRevealAnimation(delay) {
        revealAnimationTimer.interval = delay;
        revealAnimationTimer.start();
    }
    function triggerNotInWordListAnimation() {
        notInWordListAnimation.start();
    }
    function triggerWinAnimation(delay) {
        winningAnimationTimer.interval = delay;
        winningAnimationTimer.start();
    }

    Timer {
        id: revealAnimationTimer
        interval: 0
        repeat: false
        onTriggered: revealAnimation.start()
    }
    Timer {
        id: winningAnimationTimer
        interval: 0
        repeat: false
        onTriggered: winAnimation.start()
    }
}
