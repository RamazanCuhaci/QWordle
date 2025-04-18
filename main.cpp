#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "KeyInputFilter.h"
#include "gamemodel.h"
#include "wordlegame.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;


    WordleGame* wordleGame = new WordleGame(&app,":/resources/words.txt");
    GameModel* gameModel = new GameModel(wordleGame);

    KeyInputFilter keyFilter(&app);
    app.installEventFilter(&keyFilter);

    // Connect the filter's signals to wordle game logic slots
    QObject::connect(&keyFilter, &KeyInputFilter::letterTyped,
                     wordleGame, &WordleGame::typeLetter);
    QObject::connect(&keyFilter, &KeyInputFilter::deletePressed,
                     wordleGame, &WordleGame::deleteLetter);
    QObject::connect(&keyFilter, &KeyInputFilter::submitPressed,
                     wordleGame, &WordleGame::submitWord);

    // Expose to main game classes to qml
    engine.rootContext()->setContextProperty("wordleGame", wordleGame);
    engine.rootContext()->setContextProperty("gameModel", gameModel);

    engine.addImportPath("qrc:/qml");
    const QUrl url(QStringLiteral("qrc:qml/main.qml"));
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
