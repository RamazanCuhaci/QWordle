import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: introPage
    signal playPressed()


    Column {
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.centerIn: parent

        Image {
            id: wordleIcon
            source: "/images/wordle-icon.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: name
            text: "QWordle"
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            id: playButton
            text: "Play"
            onClicked: playPressed()
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
