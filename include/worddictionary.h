#ifndef WORDDICTIONARY_H
#define WORDDICTIONARY_H

#include <QObject>
#include <QSet>
#include <QString>

class WordDictionary : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString randomAnswer READ getRandomAnswer WRITE setRandomAnswer RESET
                   resetRandomAnswer NOTIFY randomAnswerChanged FINAL)
public:
    explicit WordDictionary(QObject *parent = nullptr);

    bool loadFromFile(const QString &fileName);
    bool isValidWord(const QString &word) const;

    QString getRandomAnswer() const;
    void setRandomAnswer(const QString &newRandomAnswer);
    void resetRandomAnswer();

signals:
    void randomAnswerChanged();

private:
    QSet<QString> wordSet;
    QString randomAnswer;


};

#endif // WORDDICTIONARY_H
