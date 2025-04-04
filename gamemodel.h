#ifndef GAMEMODEL_H
#define GAMEMODEL_H

#include "wordlegame.h"
#include <QAbstractListModel>

class GameModel : public QAbstractListModel {
    Q_OBJECT
public:
    explicit GameModel(WordleGame* game, QObject* parent = nullptr);

    enum Roles { LetterRole = Qt::UserRole, StateRole };
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

signals:
    void animateRow(int rowIndex);

private slots:
    void updateChangedRow(int row);
    void updateChangedCell(int row, int column);

private:
    WordleGame* game;
};

#endif // GAMEMODEL_H
