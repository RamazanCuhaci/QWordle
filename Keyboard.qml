// Keyboard.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: keyboard
    property var keyStates: ({})  // Default mapping: empty means all keys use default state 0

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
            Repeater {
                model: ["Z", "X", "C", "V", "B", "N", "M"]
                delegate: Key {
                    letter: modelData
                    state: keyboard.keyStates[modelData] !== undefined ? keyboard.keyStates[modelData] : 0
                }
            }
        }
    }
}
