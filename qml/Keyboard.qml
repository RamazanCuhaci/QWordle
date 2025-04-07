// Keyboard.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: keyboard
    property var keyStates: ({})

    Column {
        spacing: 8
        anchors.centerIn: parent

        // First row
        Row {
            spacing: 4
            Repeater {
                model: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
                delegate: Key {
                    letter: modelData
                    state: keyboard.keyStates[modelData] !== undefined ? keyboard.keyStates[modelData] : 0
                }
            }
        }

        // Second row
        Row {
            spacing: 4
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater {
                model: ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
                delegate: Key {
                    letter: modelData
                    state: keyboard.keyStates[modelData] !== undefined ? keyboard.keyStates[modelData] : 0
                }
            }
        }

        // Third row
        Row {
            spacing: 4

            // Enter key
            Rectangle {
                id: enterKey
                width: 50
                height: 40
                radius: 5
                color: "#818384"
                Text {
                    anchors.centerIn: parent
                    text: "ENTER"
                    font.bold: true
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: wordleGame.submitWord()
                    onEntered: enterKey.color ="#9a9fa1"
                    onExited: enterKey.color ="#818384"
                }

            }

            // Middle keys
            Repeater {
                model: ["Z", "X", "C", "V", "B", "N", "M"]
                delegate: Key {
                    letter: modelData
                    state: keyboard.keyStates[modelData] !== undefined ? keyboard.keyStates[modelData] : 0
                }
            }

            // Enter key
            Rectangle {
                id: deleteKey
                width: 60
                height: 40
                radius: 5
                color: "#818384"
                Text {
                    anchors.centerIn: parent
                    text: "DELETE"
                    font.bold: true
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: wordleGame.deleteLetter()
                    onEntered: deleteKey.color ="#9a9fa1"
                    onExited: deleteKey.color ="#818384"
                }

            }

        }
    }
}
