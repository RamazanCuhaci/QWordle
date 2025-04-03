#include "GameModel.h"

GameModel::GameModel(WordleGame* game, QObject* parent) : QAbstractListModel(parent), game(game) {
    connect(game, &WordleGame::boardUpdated, this, &GameModel::beginResetModel);
    connect(game, &WordleGame::boardUpdated, this, &GameModel::endResetModel);
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
