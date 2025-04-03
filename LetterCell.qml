import QtQuick 2.15

Item{

    Rectangle {
        width:board.cellWidth-5
        height:board.cellHeight-5
        color: "#121213"
        /*
        {
            switch (state) {
                case 0: return "#121213";    // Empty
                case 1: return "#538d4e";    // Correct
                case 2: return "#b59f3b";   // Misplaced
                case 3: return "#3a3a3c";     // Incorrect
                default: return "white";
            }
        }
        */
        border.color: "#3a3a3c"
        border.width: 2
        anchors.margins: 5

        Text {
            id:letterText
            text: letter
            font.pixelSize: 30
            font.bold: true
            color:"#f8f8f8"
            anchors.centerIn: parent
        }

        //Behavior on color { ColorAnimation { duration: 500 } }
    }

    Connections {
        target: letterText
        function onTextChanged() {
            print("Animation should start");
            popAnimation.start();
        }
    }
}

