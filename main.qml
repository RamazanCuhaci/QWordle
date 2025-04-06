import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    visible: true
    width: 400
    height: 600
    color: "#121213"
    title: "QWordle"

    WordleBoard {
        id: board
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        height: 360
    }

    Keyboard {
        id: keyboard
        y: 473
        width: 346
        height: 127
        anchors.horizontalCenterOffset: 0
    }

    Connections {
        target: wordleGame
        function onGameFinished(won) {
            messageDialog.text = won ? "You won!" : "Game over!"
            messageDialog.open()
        }
    }

}
