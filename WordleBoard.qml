import QtQuick 2.15
import QtQuick.Controls 2.15

GridView {
    id: board
    model: gameModel
    cellWidth: 60
    cellHeight: 60
    interactive: false

    delegate: LetterCell {
        letter: model.letter
        state: model.state
    }

    function animateRow(rowIndex, type) {
        var delay = 200;
        for (var i = 0; i < 5; i++) {
            var letterCell = board.itemAtIndex(rowIndex * 5 + i);
            if (letterCell) {
                switch (type) {
                    case 0:
                        letterCell.triggerRevealAnimation(delay * i);
                        break;
                    // case 1:
                    //     letterCell.triggerBounceAnimation(delay * i);
                    //     break;
                    // case 2:
                    //     letterCell.triggerShakeAnimation(delay * i);
                    //     break;
                    default:
                        console.warn("Unknown animation type:", type);
                        break;
                }
            }
        }
    }


    Connections {
        target: wordleGame
        function onRowAnimation(rowIndex, type) {
            animateRow(rowIndex, type);
        }
    }


}
