# QWordle 

This project is clone of a Wordle game built with **Qt (C++ & QML)** and developed with QT 6.2.2

![Gameplay Preview](preview.gif)

---

## Features

- Smooth animations for flipping, shaking, and celebrating win states
- Input from both physical and virtual keyboard
- Dynamic on-screen keyboard with color state updates
- Responsive layout that adapts to window size
- Word list validation via external file
- Restartable game logic with real-time updates
- Fully resource-packed via Qt Resource System (images, QML, text)

---

## 📂 Project Structure
<pre lang="markdown"> ``` QWordle/ ├── assets/ │ └── words.txt # Word list file for validation and answer generation ├── include/ │ ├── gamemodel.h │ ├── keyinputfilter.h │ ├── worddictionary.h │ └── wordlegame.h ├── qml/ │ ├── GamePage.qml │ ├── IntroPage.qml │ ├── LetterCell.qml │ ├── Keyboard.qml │ ├── Key.qml │ ├── WordleBoard.qml │ ├── GameOverPopup.qml │ ├── ToastPopup.qml │ ├── HowToPlayPopup.qml │ └── Main.qml ├── src/ │ ├── gamemodel.cpp │ ├── keyinputfilter.cpp │ ├── worddictionary.cpp │ └── wordlegame.cpp ├── qml.qrc # Qt resource file bundling QML and assets ├── main.cpp └── CMakeLists.txt ``` </pre>
