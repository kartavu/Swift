# Оценка - 7

**Комментарии по первому заданию:**

Тут хорошо бы ещё распределить код по классам и функциям.

```
// Сюда так просится switch :)

if randomArrayhobbi == 0 {
    ...
}

else if randomArrayhobbi == 1 {
    ...
}

else if randomArrayhobbi == 2 {
    ...
}

else if randomArrayhobbi == 3 {
    ...
}

else if randomArrayhobbi == 4 {
    ...
}

else if randomArrayhobbi == 5 {
    ...
}

else if randomArrayhobbi == 6 {
    ...
}
```


```
// Эти элементы не меняются, поэтому их лучше сделать константами

var arrayHobbi: [String] = ["Фильмы", "Игры", "Сериалы",  "Музыка", "Футбол", "Аниме", "Манга"]

var favoriteFilms: Set<String> = ["Бэтмен: Темный рыцарь", "Властелин Колец"]

var favoriteGame: Set<String> = ["God of Var", "GTA", "Ведьмак"]
```


**Комментарии по второму заданию:**

```
// Удобнее работать со значениями и мастями, если они реализованы через enum
let ranks = ["6", "7", "8", "9", "10", "J", "Q", "K", "A"]
let suits = ["♠️", "🖤", "♣️", "♦️"]

// Например, так:
enum CardsNumber: Int {
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case J = 11
    case Q = 12
    case K = 13
    case A = 14
}
// В данном случае, мы можем использовать фактическое названия наименований карт и вызвав .rawValue мы получим вес этой карты (Int-value)
```

Как и в первом задании, тут хочется видеть несколько классов, enum'ов и структур.

```
// Из контекста не ясно что это за значение
while deckIndex < 36 {

// Лучше сделать через константы
let cardDeckSize = 36
while deckIndex < cardDeckSize
```

```
// Неиспользуемый код надо удалять:
var firstPlayerScore = firstPlayerHand.count
var secondPlayerScore = secondPlayerHand.count
```

Лайк за использование смайликов и "синтаксического сахара" :)

За что снижены баллы:
~~- 1 балл за срок сдачи.~~
- 1 балл за небольшие неточности по коду в первом задании (switch и let).
- 1 балл за несколько моментов во втором задании.
