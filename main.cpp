#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "KeyInputFilter.h"
#include "gamemodel.h"
#include "keyboardmodel.h"
#include "wordlegame.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    WordleGame wordleGame(&app);

    GameModel gameModel(&wordleGame);
    KeyboardModel keyboardModel;

    KeyInputFilter keyFilter(&app);
    app.installEventFilter(&keyFilter);

    // Connect the filter's signals to your game slots
    QObject::connect(&keyFilter, &KeyInputFilter::letterTyped,
                     &wordleGame, &WordleGame::typeLetter);
    QObject::connect(&keyFilter, &KeyInputFilter::deletePressed,
                     &wordleGame, &WordleGame::deleteLetter);
    QObject::connect(&keyFilter, &KeyInputFilter::submitPressed,
                     &wordleGame, &WordleGame::submitWord);

    QObject::connect(&wordleGame, &WordleGame::updateKeyStates,
                     &keyboardModel, &KeyboardModel::keyStateUpdated);

    engine.rootContext()->setContextProperty("keyboardModel", &keyboardModel);
    engine.rootContext()->setContextProperty("wordleGame", &wordleGame);
    engine.rootContext()->setContextProperty("gameModel", &gameModel);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
