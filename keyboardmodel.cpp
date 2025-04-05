#include "KeyboardModel.h"

KeyboardModel::KeyboardModel(QObject *parent)
    : QAbstractListModel(parent)
{
    // Initialize keys with a QWERTY layout
    QString keys = {"QWERTYUIOPASDFGHJKLZXCVBNM"};
    for (QChar letter : keys) {
        m_keys.append({ letter, Default });
    }

}

int KeyboardModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_keys.count();
}

QVariant KeyboardModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() < 0 || index.row() >= m_keys.count())
        return QVariant();

    const KeyEntry &entry = m_keys.at(index.row());
    switch (role) {
    case KeyRole:
        return QString(entry.letter);
    case StateRole:
        return entry.state;
    case IndexRole:
        return index.row();
    default:
        return QVariant();
    }
}


QHash<int, QByteArray> KeyboardModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[KeyRole] = "key";
    roles[StateRole] = "state";
    roles[IndexRole] = "index";
    return roles;
}

void KeyboardModel::updateKeyState(QChar letter, int state)
{
    letter = letter.toUpper();
    for (int i = 0; i < m_keys.count(); ++i) {
        if (m_keys[i].letter == letter) {
            m_keys[i].state = static_cast<KeyState>(state);
            qDebug() << "Key state updated for" << letter << "to" << m_keys[i].state;
            emit dataChanged(index(i, 0), index(i, 0), { StateRole });
            break;
        }
    }
}

void KeyboardModel::keyStateUpdated(QString guess, QString correctWord)
{
    // Ensure the guess and correctWord have the same length
    int length = qMin(guess.length(), correctWord.length());

    // Loop through each letter of the guess and compare with the correctWord
    for (int i = 0; i < length; ++i) {
        QChar guessLetter = guess[i].toUpper();  // Normalize the guess letter to uppercase
        QChar correctLetter = correctWord[i].toUpper();  // Normalize the correct word letter to uppercase

        // Determine the state for the letter based on the comparison
        int state = 0;  // Default state: Incorrect

        if (guessLetter == correctLetter) {
            state = Correct;  // If the letter is correct and in the correct position
        } else if (correctWord.contains(guessLetter, Qt::CaseInsensitive)) {
            state = Misplaced;  // If the letter is in the word but in the wrong position
        } else {
            state = Incorrect;  // If the letter is not in the word at all
        }

        // Call the existing updateKeyState function to update the state of the key in the model
        updateKeyState(guessLetter, state);
    }
}

