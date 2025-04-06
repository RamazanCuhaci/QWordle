import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: introPage
    signal playPressed()


    Column {
        spacing: 10
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
            //font.family: "Helvetica"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {

            text: "Get 6 chances to guess a 5-letter word."
            font.pixelSize: 20
            font.family: "Helvetica"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: name.horizontalCenter
        }

        Rectangle {
            id: playButton
            width: 140
            height: 40
            radius:60
            anchors.horizontalCenter: parent.horizontalCenter
            color:"#000000"
            Text{
                anchors.centerIn: parent
                text: "Play"
                font.family: "Helvetica"
                font.pixelSize: 20
                color:"#e7e7e7"
            }
            MouseArea{
                anchors.fill:parent
                onClicked: playPressed()
                hoverEnabled: true
                onEntered: parent.color = "#2b2c2e"
                onExited: parent.color = "#000000"
            }

        }
    }

}
