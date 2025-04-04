import QtQuick 2.15

Row {
    property int rowIndex

    Repeater {
        model: 5
        LetterCell {
            letter: gameModel.data(gameModel.index(rowIndex * 5 + index, 0), Qt.UserRole + 1)
            state: gameModel.data(gameModel.index(rowIndex * 5 + index, 0), Qt.UserRole + 2)
        }
    }
}
