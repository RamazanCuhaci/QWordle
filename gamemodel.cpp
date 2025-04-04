#include "GameModel.h"

GameModel::GameModel(WordleGame* game, QObject* parent)
    : QAbstractListModel(parent), game(game) {
    connect(game, &WordleGame::rowUpdated, this, &GameModel::updateChangedRow);
    connect(game, &WordleGame::cellUpdated, this, &GameModel::updateChangedCell);
}

void GameModel::updateChangedRow(int activeRow) {


    if (activeRow >= 0 && activeRow < 6) {
        int from = activeRow * 5;
        int to = from + 4;
        emit dataChanged(index(from * 5, 0), index(to * 5 + 4, 0), { LetterRole, StateRole });
    }
}

void GameModel::updateChangedCell(int row, int column)
{
    int i = row * 5 + column;
    emit dataChanged(index(i, 0), index(i, 0));
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

