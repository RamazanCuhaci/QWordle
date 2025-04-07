import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Popup {
    id: toastPopup
    width: 120
    height: 60
    modal: false
    focus: false
    x: (parent ? parent.width : 400) / 2 - width / 2
    y: 20
    closePolicy: Popup.NoAutoClose
    background: null
    property alias message: toastText.text

    Rectangle {
        id: backgroundRect
        width: parent.width
        height: parent.height
        color: "#f8f8f8"
        opacity: 0.95
        anchors.fill: parent
        radius:20

        Text {
            id: toastText
            anchors.centerIn: parent
            font.pixelSize: 12
            color: "#121213"
            text: "Default message"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }


    onOpened: {
        toastPopup.opacity = 0.0
        openAnim.start()
        timer.start()
    }

    Timer {
        id: timer
        interval: 2000
        running: false
        onTriggered: closeAnim.start()
    }

    // Fade in
    PropertyAnimation {
        id: openAnim
        target: toastPopup
        property: "opacity"
        from: 0.0
        to: 1.0
        duration: 200
    }

    // Fade out
    PropertyAnimation {
        id: closeAnim
        target: toastPopup
        property: "opacity"
        from: 1.0
        to: 0.0
        duration: 300
        onFinished: toastPopup.close()
    }

    function show(msg) {
        message = msg
        open()
    }
}
