#include "wordlegame.h"

#include <QRandomGenerator>
#include <QDebug>

WordleGame::WordleGame(QObject* parent)
    : QObject(parent), activeRow(0), activeColumn(0)
{
    board.resize(6, QVector<LetterInfo>(5, { ' ', Empty }));
    correctWord = "APPLE";
}

void WordleGame::typeLetter(QChar letter) {
    if (activeRow < 6 && activeColumn < 5) {
        board[activeRow][activeColumn] = { letter.toUpper(), Empty };
        activeColumn++;
        emit boardUpdated();
    }
}

void WordleGame::deleteLetter() {
    if (activeColumn > 0) {
        activeColumn--;
        board[activeRow][activeColumn] = { ' ', Empty };
        emit boardUpdated();
    }
}

void WordleGame::submitWord() {
    if (activeColumn < 5) {
        qWarning() << "Word is not complete!";
        return;
    }

    QString guess;
    for (const auto& letterInfo : board[activeRow]) {
        guess.append(letterInfo.letter);
    }

    qInfo() << guess << "\n";

    if (guess == correctWord) {
        for (auto& cell : board[activeRow]) {
            cell.state = Correct;
        }
        emit boardUpdated();
        emit gameFinished(true);
        return;
    }

    // Evaluate correctness of each letter
    QMap<QChar, int> correctLetterCounts;
    for (QChar c : correctWord) correctLetterCounts[c]++;

    for (int i = 0; i < 5; ++i) {
        if (board[activeRow][i].letter == correctWord[i]) {
            board[activeRow][i].state = Correct;
            correctLetterCounts[correctWord[i]]--;
        }
    }

    for (int i = 0; i < 5; ++i) {
        if (board[activeRow][i].state != Correct && correctLetterCounts[board[activeRow][i].letter] > 0) {
            board[activeRow][i].state = Misplaced;
            correctLetterCounts[board[activeRow][i].letter]--;
        } else if (board[activeRow][i].state != Correct) {
            board[activeRow][i].state = Incorrect;
        }
    }

    emit boardUpdated();

    if (activeRow < 5) {
        activeRow++;
        activeColumn = 0;
    } else {
        emit gameFinished(false);
    }
}

void WordleGame::restartGame() {
    activeRow = 0;
    activeColumn = 0;
    board.fill(QVector<LetterInfo>(5, { ' ', Empty }));
    emit boardUpdated();
}

int WordleGame::getActiveRow() const
{
    return activeRow;
}

QVector<QVector<WordleGame::LetterInfo>> WordleGame::getBoardState() const {
    return board;
}
