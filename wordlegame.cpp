#include "wordlegame.h"
#include <QDebug>
#include <QRandomGenerator>
#include <QTimer>
#include <QVariant>
#include <QVariantMap>

WordleGame::WordleGame(QObject *parent, QString filePath)
    : QObject(parent)
    , activeRow(0)
    , activeColumn(0)
    , dictionary(new WordDictionary(this))
{
    board.resize(6, QVector<LetterInfo>(5, {' ', Default}));
    dictionary->loadFromFile(filePath);
    correctWord = dictionary->getRandomAnswer();
}

void WordleGame::typeLetter(QChar letter)
{
    if (activeRow < 6 && activeColumn < 5)
    {
        board[activeRow][activeColumn] = {letter.toUpper(), Default};
        emit cellUpdated(activeRow, activeColumn);
        activeColumn++;
    }
}

void WordleGame::deleteLetter()
{
    if (activeColumn > 0)
    {
        activeColumn--;
        board[activeRow][activeColumn] = {' ', Default};
        emit cellUpdated(activeRow, activeColumn);
    }
}

void WordleGame::submitWord()
{
    if (activeColumn < 5)
    {
        qWarning() << "Word is not complete!";

        // Type 1: Shaking animation
        emit rowAnimation(activeRow, 1);
        return;
    }

    QString guess;
    for (const auto &letterInfo : board[activeRow])
    {
        guess.append(letterInfo.letter);
    }

    qDebug() << "Submitted word is : " << guess << "\n";

    if (guess == correctWord)
    {
        for (auto &cell : board[activeRow])
        {
            cell.state = Correct;
        }
        emit rowUpdated(activeRow);

        // Type 0: Reveal animation
        emit rowAnimation(activeRow, 0);

        // This is for to ensure that the win animation plays
        // after the reveal animation is finished.
        QTimer::singleShot(2000, [this]()
        {
            emit showNotification("Splendid");
            // Type 2: Win animation.
            emit rowAnimation(activeRow-1, 2);
            emit gameFinished(true);
        });
    }

    if (!dictionary->isValidWord(guess))
    {
        emit showNotification("Not in word list");
        emit rowAnimation(activeRow,1);
        return;
    }

    // Evaluate correctness of each letter
    QMap<QChar, int> correctLetterCounts;
    for (QChar c : correctWord)
    {
        correctLetterCounts[c]++;
    }

    for (int i = 0; i < 5; ++i)
    {
        if (board[activeRow][i].letter == correctWord[i])
        {
            board[activeRow][i].state = Correct;
            correctLetterCounts[correctWord[i]]--;
        }
    }

    for (int i = 0; i < 5; ++i)
    {
        if (board[activeRow][i].state != Correct
            && correctLetterCounts[board[activeRow][i].letter] > 0)
        {
            board[activeRow][i].state = Misplaced;
            correctLetterCounts[board[activeRow][i].letter]--;
        }
        else if (board[activeRow][i].state != Correct)
        {
            board[activeRow][i].state = Incorrect;
        }
    }


    emit rowUpdated(activeRow);

    // Type 0 = reveal animation
    emit rowAnimation(activeRow, 0);


    for (int i = 0; i < 5; ++i)
    {
        QChar letter = board[activeRow][i].letter;
        int state = board[activeRow][i].state;

        // If a letter was already marked as higher priority, skip updating it
        if (m_keyStates.contains(letter))
        {
            int existingState = m_keyStates[letter].toInt();
            if (existingState == 1 || (existingState == 2 && state == 3))
            {
                continue;
            }
        }
        m_keyStates[letter] = state;
    }

    updateKeyStates(m_keyStates);


    // Check the game finish
    // Or move the next row
    if (activeRow < 5)
    {
        activeRow++;
        activeColumn = 0;
    }
    else
    {
        emit showNotification(correctWord);
        emit gameFinished(false);
    }
}

void WordleGame::restartGame()
{
    activeRow = 0;
    activeColumn = 0;
    board.fill(QVector<LetterInfo>(5, {' ', Default}));
    dictionary->resetRandomAnswer();
    correctWord = dictionary->getRandomAnswer();
    qDebug() << "GAME RESTARTED\n" ;
    m_keyStates.clear();
    emit updateKeyStates(m_keyStates);
    emit boardUpdated();
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
