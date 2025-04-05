#ifndef KEYBOARDMODEL_H
#define KEYBOARDMODEL_H

#include <QAbstractListModel>
#include <QList>
#include <QChar>

class KeyboardModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum KeyState {
        Default = 0,
        Correct,
        Misplaced,
        Incorrect
    };
    Q_ENUM(KeyState)

    enum Roles {
        KeyRole = Qt::UserRole + 1,
        StateRole,
        IndexRole
    };

    explicit KeyboardModel(QObject *parent = nullptr);

    // QAbstractListModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    void updateKeyState(QChar letter, int state);

public slots:
    void keyStateUpdated(QString guess, QString correctWord);

private:
    struct KeyEntry {
        QChar letter;
        KeyState state;
    };

    QList<KeyEntry> m_keys;
};

#endif // KEYBOARDMODEL_H
