#include "wordlegame.h"

#include <QDebug>
#include <QRandomGenerator>

WordleGame::WordleGame(QObject *parent)
    : QObject(parent)
    , activeRow(0)
    , activeColumn(0)
    , dictionary(new WordDictionary(this))
{
    board.resize(6, QVector<LetterInfo>(5, {' ', Default}));
    dictionary->loadFromFile("words.txt");
    correctWord = dictionary->getRandomAnswer();
}

void WordleGame::typeLetter(QChar letter)
{
    if (activeRow < 6 && activeColumn < 5) {
        board[activeRow][activeColumn] = {letter.toUpper(), Default};
        emit cellUpdated(activeRow, activeColumn);
        activeColumn++;
    }
}

void WordleGame::deleteLetter()
{
    if (activeColumn > 0) {
        activeColumn--;
        board[activeRow][activeColumn] = {' ', Default};
        emit cellUpdated(activeRow, activeColumn);
    }
}

void WordleGame::submitWord()
{
    if (activeColumn < 5) {
        qWarning() << "Word is not complete!";
        return;
    }

    QString guess;
    for (const auto &letterInfo : board[activeRow]) {
        guess.append(letterInfo.letter);
    }

    qInfo() << guess << "\n";

    if (guess == correctWord) {
        for (auto &cell : board[activeRow]) {
            cell.state = Correct;
        }
        emit rowUpdated(activeRow);
        emit gameFinished(true);
        emit
    }

    // Evaluate correctness of each letter
    QMap<QChar, int> correctLetterCounts;
    for (QChar c : correctWord)
        correctLetterCounts[c]++;

    for (int i = 0; i < 5; ++i) {
        if (board[activeRow][i].letter == correctWord[i]) {
            board[activeRow][i].state = Correct;
            correctLetterCounts[correctWord[i]]--;
        }
    }

    for (int i = 0; i < 5; ++i) {
        if (board[activeRow][i].state != Correct
            && correctLetterCounts[board[activeRow][i].letter] > 0) {
            board[activeRow][i].state = Misplaced;
            correctLetterCounts[board[activeRow][i].letter]--;
        } else if (board[activeRow][i].state != Correct) {
            board[activeRow][i].state = Incorrect;
        }
    }

    emit rowUpdated(activeRow);
    emit rowAnimation(activeRow, 0);
    emit updateKeyStates(guess, correctWord);

    if (activeRow < 5) {
        activeRow++;
        activeColumn = 0;
    } else {
        emit gameFinished(false);
    }
}

void WordleGame::restartGame()
{
    activeRow = 0;
    activeColumn = 0;
    board.fill(QVector<LetterInfo>(5, {' ', Default}));
    //This should be update all board
    //emit boardUpdated();
}

int WordleGame::getActiveRow() const
{
    return activeRow;
}

int WordleGame::getActiveColumn() const
{
    return activeColumn;
}

QVector<QVector<WordleGame::LetterInfo>> WordleGame::getBoardState() const
{
    return board;
}
