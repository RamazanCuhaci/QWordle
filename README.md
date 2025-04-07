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

## Examples

### Example of Winning Scenario
- This scenario includes:
  - Winning mechanism  
  - Word reveal animation  
  - Coloring cell and keyboard  
  - Typing animation  
  - Winning animation
https://github.com/user-attachments/assets/75fcac48-2b0b-41a3-929b-27705201075e



### Example of Losing Scenario

https://github.com/user-attachments/assets/84d3b4e2-c904-4506-aa0d-801b3434d6c4




## 🧠 Architecture Overview

This project cleanly separates concerns between the QML user interface and the C++ game logic. Below are the core C++ classes and their responsibilities:

### `WordleGame` – Core Game Logic

- Maintains the game state: current row, column, correct answer, and letter board.
- Handles word input, deletion, submission, and restarting.
- Validates guesses and assigns letter states:
  - `Correct` (green)
  - `Misplaced` (yellow)
  - `Incorrect` (gray)
- Emits key signals:
  - `rowUpdated`, `cellUpdated` — for model updates
  - `rowAnimation` — to trigger animations in QML
  - `gameFinished(bool)` — indicates win/loss
  - `updateKeyStates(QVariantMap)` — updates virtual keyboard colors
  - `showNotification(QString)` — triggers toast messages

---

### `WordDictionary` – Word Validation

- Loads valid guess words from an external file (`words.txt`).
- Provides a randomly selected answer from the word list.
- Checks if a submitted word exists in the dictionary.
- Signals when the answer is changed (`randomAnswerChanged`).

---

### `GameModel` – QML-Compatible Game State

- Subclass of `QAbstractListModel`.
- Exposes the game board to QML in a model-friendly format.
- Flattens the 2D board into a list, with:
  - `LetterRole`: the letter shown in the cell
  - `StateRole`: the result status (`Correct`, `Misplaced`, etc.)
- Connects to `WordleGame` signals to emit data updates efficiently (`dataChanged`, `beginResetModel`).

Using a model  `QAbstractListModel` provides several advantages in a QML-heavy UI:
- Automatic UI updates through bindings — no manual syncing needed.
- Efficient rendering with `ListView`, `Repeater`, or `GridView`.
- Clean separation of logic (C++) and presentation (QML).
- Example usage:

  ```qml
  model: gameModel
  delegate: LetterCell {
      letter: model.LetterRole
      state: model.StateRole
  }
