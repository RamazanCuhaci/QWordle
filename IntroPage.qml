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

        Rectangle {
            id: playButton
            width: 80
            height: 30
            radius:10
            anchors.horizontalCenter: parent.horizontalCenter
            color:"#000000"
            Text{
                anchors.centerIn: parent
                text: "Play"
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
