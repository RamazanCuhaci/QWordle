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


    signal revealAnimationFinished()
    signal winAnimationFinished()

    // Flip effect: scale applied to the whole letter cell
    transform: Scale {
        id: scaleTransform
        origin.x: width / 2
        origin.y: height / 2
        xScale: 1.0
        yScale: 1.0
    }

    // Outer container for the cell content.
    // We use two Translate transforms here:
    // - shakeTranslate: for shake animations (not-in-word)
    // - winTranslate: for win animation (bounce effect)
    Item {
        id: cellContainer
        anchors.fill: parent
        transform: [
            Translate { id: shakeTranslate },
            Translate { id: winTranslate }  // win animation target
        ]

        // Inner container to flip both rectangle & text together.
        Item {
            id: flipContainer
            anchors.centerIn: parent
            width: parent.width - 5
            height: letterCell.originalHeight - 5
            scale: 1.0

            Rectangle {
                id: cell
                anchors.fill: parent
                border.color: letterCell.borderColor
                border.width: 2
                color: letterCell.inColor
            }

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
    }

    // Typing bounce animation
    onLetterChanged: {
        if (letter !== " ") {
            typeAnimation.start();
        }
    }

    SequentialAnimation {
        id: typeAnimation
        ScaleAnimator { target: cell; to: 1.2; duration: 120; easing.type: Easing.OutQuad }
        ScaleAnimator { target: cell; to: 1.0; duration: 120; easing.type: Easing.InQuad }
    }

    // Shake animation for "not in word list"
    SequentialAnimation {
        id: notInWordListAnimation
        PropertyAnimation { target: shakeTranslate; property: "x"; to: -10; duration: 80; easing.type: Easing.InOutQuad }
        PropertyAnimation { target: shakeTranslate; property: "x"; to: 10; duration: 80; easing.type: Easing.InOutQuad }
        PropertyAnimation { target: shakeTranslate; property: "x"; to: -6; duration: 60; easing.type: Easing.InOutQuad }
        PropertyAnimation { target: shakeTranslate; property: "x"; to: 6; duration: 60; easing.type: Easing.InOutQuad }
        PropertyAnimation { target: shakeTranslate; property: "x"; to: 0; duration: 40; easing.type: Easing.OutQuad }
    }

    // Flip animation (vertical flip using yScale)
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
        onFinished: {revealAnimationFinished()}
    }

    // Winning (bounce) animation: animate winTranslate.y
    SequentialAnimation {
        id: winAnimation
        PropertyAnimation {
            target: winTranslate
            property: "y"
            from: 0
            to: -20
            duration: 150
            easing.type: Easing.OutQuad
        }

        PropertyAnimation {
            target: winTranslate
            property: "y"
            from: -20
            to: 0
            duration: 200
            easing.type: Easing.OutBounce
        }
    }

    // Functions to trigger animations with an optional delay
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
