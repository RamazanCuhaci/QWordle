import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    visible: true
    width: 1024
    height: 768
    title: qsTr("QWordle")

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Component {
            IntroPage {
                onPlayPressed: stackView.push("GamePage.qml")
            }
        }
    }
}

