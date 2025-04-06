#include "worddictionary.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>
 #include <QRandomGenerator>

WordDictionary::WordDictionary(QObject *parent)
    : QObject(parent)
{
}

bool WordDictionary::loadFromFile(const QString &fileName)
{
    QFile file(fileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Could not open word list file:" << fileName;
        return false;
    }

    wordSet.clear();
    randomAnswer.clear();

    QTextStream in(&file);
    int count = 0;

    while (!in.atEnd()) {
        QString line = in.readLine().trimmed().toLower();
        if (!line.isEmpty()) {
            wordSet.insert(line);
            // Reservoir sampling to select a random word
            ++count;
            if (QRandomGenerator::global()->bounded(count) == 0) {
                randomAnswer = line;
            }
        }
    }

    file.close();

    qDebug() << "Loaded" << wordSet.size() << "words.";
    qDebug() << "Selected random answer word:" << randomAnswer;
    return !wordSet.isEmpty();
}


bool WordDictionary::isValidWord(const QString &word) const
{
    return wordSet.contains(word);
}

QString WordDictionary::getRandomAnswer() const
{
    return randomAnswer;
}

void WordDictionary::setRandomAnswer(const QString &newRandomAnswer)
{
    if (randomAnswer == newRandomAnswer)
        return;
    randomAnswer = newRandomAnswer;
    emit randomAnswerChanged();
}

void WordDictionary::resetRandomAnswer()
{
    if (wordSet.isEmpty())
        return;

    int targetIndex = QRandomGenerator::global()->bounded(wordSet.size());
    int i = 0;
    for (const QString& word : wordSet) {
        if (i == targetIndex) {
            randomAnswer = word;
        ++i;
    }
    }
}
