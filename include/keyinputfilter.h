#ifndef KEYINPUTFILTER_H
#define KEYINPUTFILTER_H

#include <QObject>
#include <QEvent>
#include <QKeyEvent>

class KeyInputFilter : public QObject {
    Q_OBJECT
public:
    explicit KeyInputFilter(QObject* parent = nullptr);

signals:
    void letterTyped(QChar letter);
    void deletePressed();
    void submitPressed();

protected:
    bool eventFilter(QObject* obj, QEvent* event) override;
};

#endif // KEYINPUTFILTER_H
