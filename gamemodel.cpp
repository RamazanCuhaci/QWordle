#include "GameModel.h"

GameModel::GameModel(WordleGame* game, QObject* parent)
    : QAbstractListModel(parent), game(game) {
    connect(game, &WordleGame::boardUpdated, this, &GameModel::updateChangedRow);
}

void GameModel::updateChangedRow() {
    if (!game) return;
    int row = game->getActiveRow();
    if (row >= 0 && row < 6) {
        emit dataChanged(index(row * 5, 0), index(row * 5 + 4, 0), { LetterRole, StateRole });
    }
}
int GameModel::rowCount(const QModelIndex&) const {
    return 30; // 6 rows × 5 columns
}

QVariant GameModel::data(const QModelIndex& index, int role) const {
    int row = index.row() / 5;
    int col = index.row() % 5;

    if (row >= 6 || col >= 5) return QVariant();

    auto boardState = game->getBoardState();
    if (role == LetterRole) return boardState[row][col].letter;
    if (role == StateRole) return boardState[row][col].state;

    return QVariant();
}

QHash<int, QByteArray> GameModel::roleNames() const {
    return { { LetterRole, "letter" }, { StateRole, "state" } };
}
