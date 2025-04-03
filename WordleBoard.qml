import QtQuick 2.15
import QtQuick.Controls 2.15

GridView {
    id: board
    model: gameModel
    cellWidth: 60
    cellHeight: 60
    interactive: false

    delegate: LetterCell{
        letter: model.letter
        state:model.state
    }

}
