import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: howToPlayPopup
    width: 400
    height: 520
    modal: true
    focus: true
    dim: true
    background: Rectangle {
        color: "#121213"
        radius: 12
    }
    anchors.centerIn: parent
    Item {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        Column {
            spacing: 20
            anchors.centerIn: parent
            width: parent.width * 0.9

            // Header
            RowLayout {
                width: parent.width
                spacing: 0

                Text {
                    text: "How To Play"
                    font.pixelSize: 28
                    color: "white"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                }

                Rectangle {
                    width: 40
                    height: 40
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.margins: 4
                    color:"#121213"
                    Text{
                        anchors.centerIn: parent
                        text: "X"
                        color:"#e7e7e7"
                        font.pixelSize: 30
                    }
                    MouseArea{
                        anchors.fill:parent
                        onClicked: howToPlayPopup.close()
                        hoverEnabled: true
                        onEntered: parent.color = "#2b2c2e"
                        onExited: parent.color ="#121213"
                    }
                }
            }

            Text {
                text: "Guess the Wordle in 6 tries.\n\nEach guess must be a valid 5-letter word.\nThe color of the tiles will change to show how close your guess was to the word."
                color: "#d7dadc"
                font.pixelSize: 16
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            // Example 1 - Correct
            Column {
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    spacing: 4
                    scale: 0.8
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: [
                            { letter: "W", state: 1, flip: true },
                            { letter: "O", state: 0 },
                            { letter: "R", state: 0 },
                            { letter: "D", state: 0 },
                            { letter: "Y", state: 0 }
                        ]
                        delegate: LetterCell {
                            letter: modelData.letter
                            state: modelData.state
                            Component.onCompleted: {
                                if (modelData.flip) triggerRevealAnimation(0, false)
                            }
                        }
                    }
                }

                Text {
                    text: "W is in the word and in the correct spot."
                    color: "#d7dadc"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
            }

            // Example 2 - Misplaced
            Column {
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    spacing: 4
                    scale: 0.8
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: [
                            { letter: "L", state: 0 },
                            { letter: "I", state: 2, flip: true },
                            { letter: "G", state: 0 },
                            { letter: "H", state: 0 },
                            { letter: "T", state: 0 }
                        ]
                        delegate: LetterCell {
                            letter: modelData.letter
                            state: modelData.state
                            Component.onCompleted: {
                                if (modelData.flip) triggerRevealAnimation(0, false)
                            }
                        }
                    }
                }

                Text {
                    text: "I is in the word but in the wrong spot."
                    color: "#d7dadc"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
            }

            // Example 3 - Incorrect
            Column {
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    spacing: 4
                    scale: 0.8
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: [
                            { letter: "R", state: 0 },
                            { letter: "O", state: 0 },
                            { letter: "G", state: 0 },
                            { letter: "U", state: 3, flip: true },
                            { letter: "E", state: 0 }
                        ]
                        delegate: LetterCell {
                            letter: modelData.letter
                            state: modelData.state
                            Component.onCompleted: {
                                if (modelData.flip) triggerRevealAnimation(0, false)
                            }
                        }
                    }
                }

                Text {
                    text: "U is not in the word in any spot."
                    color: "#d7dadc"
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }
            }
        }
    }
}
