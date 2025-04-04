#include "KeyInputFilter.h"

KeyInputFilter::KeyInputFilter(QObject* parent)
    : QObject(parent) {}

bool KeyInputFilter::eventFilter(QObject* obj, QEvent* event) {
    if (event->type() == QEvent::KeyPress) {
        QKeyEvent* keyEvent = static_cast<QKeyEvent*>(event);
        if (keyEvent->key() >= Qt::Key_A && keyEvent->key() <= Qt::Key_Z) {
            QChar letter = QChar(keyEvent->key());
            emit letterTyped(letter);
            return true;
        } else if (keyEvent->key() == Qt::Key_Backspace) {
            emit deletePressed();
            return true;
        } else if (keyEvent->key() == Qt::Key_Return || keyEvent->key() == Qt::Key_Enter) {
            emit submitPressed();
            return true;
        }
    }
    return QObject::eventFilter(obj, event);
}
