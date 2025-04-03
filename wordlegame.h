#ifndef WORDLEGAME_H
#define WORDLEGAME_H

#include <QObject>

class WordleGame : public QObject {
    Q_OBJECT
public:
    explicit WordleGame(QObject* parent = nullptr);

    Q_INVOKABLE void submitWord(); // Check current word
    Q_INVOKABLE void typeLetter(QChar letter); // Add letter to active cell
    Q_INVOKABLE void deleteLetter(); // Delete last letter
    Q_INVOKABLE void restartGame(); // Reset the game

    enum LetterState { Correct, Misplaced, Incorrect, Empty };
    Q_ENUM(LetterState)

    struct LetterInfo {
        QChar letter;
        LetterState state;
    };

    QVector<QVector<LetterInfo>> getBoardState() const; // Get board data

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
