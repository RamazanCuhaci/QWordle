import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: gamePage
    property bool tutorialShown: false
    //anchors.fill: parent
    Rectangle {
        anchors.fill: parent
        color: "#121213" // Main dark background
    }

    // Top Bar with Help Button
    Rectangle {
        id: topBar
        width: parent.width
        height: 60
        color: "#121213"
        border.color: "#3a3a3c"

        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            spacing: 10
            padding: 10

            Rectangle {
                id: howToPlayPopupButton
                width: 50
                height: 50
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                Layout.margins: 4
                color:"#121213"
                radius:20
                border.width:2
                border.color:"white"
                Text{
                    anchors.centerIn: parent
                    text: "?"
                    color:"#e7e7e7"
                    font.pixelSize: 40
                }
                MouseArea{
                    anchors.fill:parent
                    onClicked: howToPlayPopup.open()
                    hoverEnabled: true
                    onEntered: parent.color = "#2b2c2e"
                    onExited: parent.color ="#121213"
                }

            }
        }
    }

    WordleBoard {
        id: board
        anchors.top: topBar.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: 300
        height: 360
    }

    Keyboard {
        id: keyboard
        anchors.top: board.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: 346
        height: 127
    }

    ToastPopup {
        id: toast
    }

    HowToPlayPopup{
        id:howToPlayPopup
    }

    Connections {
        target: wordleGame

        function onShowNotification(message) {
            toast.show(message);
        }

        function onGameFinished(win) {
            gameOverPopup.win = win;
            gameOverPopup.open();
        }

        function onUpdateKeyStates(keyStateMapping) {
            keyboard.keyStates = keyStateMapping;
        }
    }

    // Show the popup when game loads for the first time
    Component.onCompleted: {
        if (!tutorialShown) {
            howToPlayPopup.open()
            tutorialShown = true
        }
    }

    GameOverPopup {
        id: gameOverPopup
        width: parent.width * 0.8
        onTryAgain: {
            wordleGame.restartGame()
        }

        onExitGame: {
            Qt.quit()
        }
    }

}
