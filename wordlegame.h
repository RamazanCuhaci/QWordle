#ifndef WORDLEGAME_H
#define WORDLEGAME_H

#include <QObject>

class WordleGame : public QObject {
    Q_OBJECT
public:
    explicit WordleGame(QObject* parent = nullptr);

    Q_INVOKABLE void submitWord();
    Q_INVOKABLE void typeLetter(QChar letter);
    Q_INVOKABLE void deleteLetter();
    Q_INVOKABLE void restartGame();

    enum LetterState { Empty, Correct, Misplaced, Incorrect };
    Q_ENUM(LetterState)

    struct LetterInfo {
        QChar letter;
        LetterState state;
    };

    QVector<QVector<LetterInfo>> getBoardState() const; // Get board data
    int getActiveRow() const;

signals:
    void boardUpdated(); // Notify UI of changes
    void gameFinished(bool won);

private:
    QString correctWord;
    int activeRow;
    int activeColumn;
    QVector<QVector<LetterInfo>> board;

    void evaluateGuess();
};


#endif // WORDLEGAME_H
