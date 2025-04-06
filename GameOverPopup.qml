import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: gameOverPopup
    modal: true
    focus: true
    width: parent.width * 0.8
    height: 200
    anchors.centerIn: parent
    background: Rectangle {
        color: "#121213"
        radius: 12
    }

    property bool win: false

    signal tryAgain()
    signal exitGame()

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: gameOverPopup.win ? "You Win!" : "You Lose"
            color: "white"
            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
        }

        Row {
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Try Again"
                onClicked: {
                    gameOverPopup.close()
                    tryAgain()
                }
            }

            Button {
                text: "Exit"
                onClicked: {
                    exitGame()
                }
            }
        }
    }
}
