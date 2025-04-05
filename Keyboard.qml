import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    width: parent.width
    height: parent.height / 2
    anchors.horizontalCenter: parent.horizontalCenter

    Flow {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        Repeater {
            model: keyboardModel
            delegate: Key {
                letter: model.key
                state: model.state
                width: parent.width / 12
                height: 50
                font.pixelSize: 18

            }
        }
        Button {
            text: "Del"
            width: 75
            height: 50
            onClicked: wordleGame.deleteLetter()
        }
        Button {
            text: "Enter"
            width: 100
            height: 50
            onClicked: wordleGame.submitWord()
        }
    }
}


