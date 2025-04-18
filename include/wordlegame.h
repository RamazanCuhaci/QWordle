#ifndef WORDLEGAME_H
#define WORDLEGAME_H

#include <QObject>
#include <QMap>
#include "worddictionary.h"

class WordleGame : public QObject {
    Q_OBJECT

public:
    explicit WordleGame(QObject* parent = nullptr, QString filePath = nullptr );

    Q_INVOKABLE void submitWord();
    Q_INVOKABLE void typeLetter(QChar letter);
    Q_INVOKABLE void deleteLetter();
    Q_INVOKABLE void restartGame();

    enum LetterState { Default, Correct, Misplaced, Incorrect };
    Q_ENUM(LetterState)

    struct LetterInfo {
        QChar letter;
        LetterState state;
    };

    QVector<QVector<LetterInfo>> getBoardState() const; // Get board data
    int getActiveRow() const;
    int getActiveColumn() const;

signals:
    void rowUpdated(int row);
    void cellUpdated(int row, int column);
    void gameFinished(bool won);

    // 0:flip animation
    // 1:not in word list anim
    // 2:win animation
    void rowAnimation(int row, int type);

    // For updating keyboard key color for result
    void updateKeyStates(QVariantMap keyStates);


    void showNotification(QString message);

    void boardReset();

private:
    QString correctWord;
    int activeRow;
    int activeColumn;
    QVector<QVector<LetterInfo>> board;

    WordDictionary* dictionary;

    QVariantMap m_keyStates;
};


#endif // WORDLEGAME_H
