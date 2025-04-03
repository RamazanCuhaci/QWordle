import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    spacing: 5
    anchors.horizontalCenter: parent.horizontalCenter

    property var keys: [
        "QWERTYUIOP",
        "ASDFGHJKL",
        "ZXCVBNM"
    ]

    Repeater {
        model: keys
        Row {
            spacing: 5
            Repeater {
                model: modelData.split("")
                Button {
                    text: modelData
                    width: 50
                    height: 50
                    onPressed: wordleGame.typeLetter(text)
                }
            }
        }
    }

    Row {
        spacing: 5
        Button {
            text: "Del"
            width: 75
            height: 50
            onPressed: wordleGame.deleteLetter()
        }
        Button {
            text: "Enter"
            width: 100
            height: 50
            onClicked: wordleGame.submitWord()
        }
    }
}
