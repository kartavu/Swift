// Я решил сделать текст про свои хобби, текст получился небольшой, но он рандомно генерирует одни из моих хобби и в зависимости от сгененрированного хобби он выводит что мне нравится в этом хобби
var myHobbi: String = ""

var aboutMe: [Int: String] = [1: "cтудентом"]
let firstFactAboutMe = aboutMe[1]!

myHobbi += "Я являюсь \(firstFactAboutMe) и сейчас я расскажу о своих хобби."

var arrayHobbi: [String] = ["Фильмы", "Игры", "Сериалы",  "Музыка", "Футбол", "Аниме", "Манга"]
let randomArrayhobbi = Int.random(in: 0..<arrayHobbi.count)

myHobbi += " Одним из моих хобби является \(arrayHobbi[randomArrayhobbi]). "
//randomArrayhobbi

if randomArrayhobbi == 0 {
    var favoriteFilms: Set<String> = ["Бэтмен: Темный рыцарь", "Властелин Колец"]
    let film = favoriteFilms.randomElement()!
    
    myHobbi += "Мои любимые фильмы: "
    myHobbi += (["Бэтмен: Темный рыцарь", "Властелин Колец"].joined(separator: ", "))
}

else if randomArrayhobbi == 1 {
    var favoriteGame: Set<String> = ["God of Var", "GTA", "Ведьмак"]
    let game = favoriteGame.randomElement()!
    
    myHobbi += "Моими фавориты в игровой индустрии: "
    myHobbi += (["God of Var", "GTA", "Ведьмак"].joined(separator: ", "))
}

else if randomArrayhobbi == 2 {
    var favoriteSerial: Set<String> = ["Ведьмак"]
    let serial = favoriteSerial.randomElement()!
    
    myHobbi += "Мой любимый сериал \(serial). "
}

else if randomArrayhobbi == 3 {
    var favoriteMusic: Set<String> = ["OBLADAET", "OG BUDA", "SODA LUV", "Travis Scott"]
    let music = favoriteMusic.randomElement()!
    
    myHobbi += "Мои любимые исполнители: "
    myHobbi += (["OBLADAET", "OG BUDA", "SODA LUV", "Travis Scott"].joined(separator: ", "))
}

else if randomArrayhobbi == 4 {
    var favoriteFootball: Set<String> = ["Levandovski", "Ronaldo", "Holand"]
    let football = favoriteFootball.randomElement()!
    
    myHobbi += "Мои любимые футболисты: "
    myHobbi += (["Levandovski", "Ronaldo", "Holand"].joined(separator: ", "))
}

else if randomArrayhobbi == 5 {
    var favoriteAnime: Set<String> = ["One Piece"]
    let anime = favoriteAnime.randomElement()!
    
    myHobbi += "Моим любимым аниме является \(anime). "
}

else if randomArrayhobbi == 6 {
    var favoriteManga: Set<String> = ["Поднятие уровня в одиночку", "Начало после конца"]
    let manga = favoriteManga.randomElement()!
    
    myHobbi += "Моей любимой мангой является "
    myHobbi += (["Поднятие уровня в одиночку", "Начало после конца"].joined(separator: ", "))
}

print(myHobbi)
print()
print()
print()
// Карточная игра
print("Карточная игра")
// просто создаю переменную ранг и масть карт
let ranks = ["6", "7", "8", "9", "10", "J", "Q", "K", "A"]
let suits = ["♠️", "🖤", "♣️", "♦️"]
var deck: [(String, String)] = []

// заполняю колоду
for rank in ranks {
    for suit in suits {
        deck.append((rank, suit))
    }
}

//перемешиваю
deck.shuffle()

// создаю двух игроков
var firstPlayer: [(String, String)] = []
var secondPlayer: [(String, String)] = []


// функция для определения победителя в ходе
func canBeat(_ firstCard: (String, String), _ secondCard: (String, String)) -> Int {
    let value = ["6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    if firstCard.1 == secondCard.1 && value.firstIndex(of: firstCard.0)! > value.firstIndex(of: secondCard.0)! {
        return 1 // если карта ходящего больше, то он победил
    }
    else if firstCard.1 == secondCard.1 && value.firstIndex(of: secondCard.0)! > value.firstIndex(of: firstCard.0)! {
        return 2 // если карта ходящего меньше, то он проиграл
    }
    else {
        return firstCard.1 > secondCard.1 ? 1:2 // если у них карты разной масти значит побеждает игрок, у которого карта больше
    }
}
    
// функция самой игры
func CardGame() -> Int {
    var firstPlayerIndex = 0 // индекс карты в руке у первого игрока
    var secondPlayerIndex = 0 // индекс карты в руке у второго игрока
    var deckIndex = 12 // индекс карты в колоде
    var firstPlayerHand: [(String, String)] = []
    var secondPlayerHand: [(String, String)] = []
    var winnerInRound = 0 // 1 – победил игрок победли, 2 – победил второй игрок
    
    // раздаю игрокам карты
    for i in 0..<6 {
        firstPlayerHand.append(deck[i])
        secondPlayerHand.append(deck[i+6])
    }
    
    // начинаем игру
    while deckIndex < 36 {
        print("Карт в руках: \(deckIndex) / карт в колоде: 36") // информация сколько карт в колоде
        print("Первый игрок: (карт в руке у игрока: \(firstPlayerHand.count): ")
        
        for card in firstPlayerHand {
            print("\(card.0) \(card.1)")
        }
        print("Второй игрок: (карт в руке у игрока: \(secondPlayerHand.count): ")
        
        for card in secondPlayerHand {
            print("\(card.0) \(card.1)")
        }
        
        // для выбора хода у первого игрока
        let firstPlayerCard = firstPlayerHand.randomElement()!
        firstPlayerHand.removeAll(where: { $0 == firstPlayerCard })
        print("Первый игрок  играет: \(firstPlayerCard.0) \(firstPlayerCard.1)")
        
        // для выбора хода у второго игрока
        let secondPlayerCard = secondPlayerHand.randomElement()!
        secondPlayerHand.removeAll(where: { $0 == secondPlayerCard })
        print("Второй игрок  играет: \(secondPlayerCard.0) \(secondPlayerCard.1)")
        
        var roundWinner = canBeat(firstPlayerCard, secondPlayerCard)
        
        // определение победителя в раунде
        if roundWinner == 1 {
//            print("В этом раунде победу одержал Первый игрок 🎉🎉🎉")
            firstPlayerHand.append(secondPlayerCard)
            firstPlayerHand.append(firstPlayerCard)
        }
        else if roundWinner == 2 {
//            print("В этом раунде победу одержал Второй игрок 🎉🎉🎉")
            secondPlayerHand.append(firstPlayerCard)
            secondPlayerHand.append(secondPlayerCard)
        }
        else {
//            print("В этом раунде одержал игрок")
        }
        // переход к следующей карте в колоде
        deckIndex += 1
        
        // проверяем колоду на наличие карт
        if deckIndex == 36 {
            // начинаем новый раунд
            var firstPlayerScore = firstPlayerHand.count
            var secondPlayerScore = secondPlayerHand.count
            
            while firstPlayerHand.count > 0 && secondPlayerHand.count > 0 {
                
                print("Первый игрок: (карт в руке у игрока: \(firstPlayerHand.count): ")
                
                for card in firstPlayerHand {
                    print("\(card.0) \(card.1)")
                }
                print("Второй игрок: (карт в руке у игрока: \(secondPlayerHand.count): ")
                
                for card in secondPlayerHand {
                    print("\(card.0) \(card.1)")
                }
            
                let firstPlayerCard = firstPlayerHand.randomElement()!
                firstPlayerHand.removeAll(where: { $0 == firstPlayerCard })
                print("Первый игрок  играет: \(firstPlayerCard.0) \(firstPlayerCard.1)")
                
                let secondPlayerCard = secondPlayerHand.randomElement()!
                secondPlayerHand.removeAll(where: { $0 == secondPlayerCard })
                print("Второй игрок  играет: \(secondPlayerCard.0) \(secondPlayerCard.1)")
                
                let roundWinner = canBeat(firstPlayerCard, secondPlayerCard)
                
                if roundWinner == 1 {
                    print("В этом раунде победу одержал Первый игрок 🎉🎉🎉")
                    firstPlayerHand.append(secondPlayerCard)
                    firstPlayerHand.append(firstPlayerCard)
                }
                else {
                    print("В этом раунде победу одержал Второй игрок 🎉🎉🎉")
                    secondPlayerHand.append(firstPlayerCard)
                    secondPlayerHand.append(secondPlayerCard)
                }
            }
            
            if firstPlayerHand.count == 0 {
//                print("Первый игрок оказывается победителем в этой напряженной игре")
                winnerInRound = 1
            }
            else {
//                print("Второй игрок оказывается победителем в этой напряженной игре")
                winnerInRound = 2
            }
        }
    }
    return winnerInRound
}
    
let winnerOfGame = CardGame()

if winnerOfGame == 1 {
    print("Первый игрок оказывается победителем")
}
else {
    print("Второй игрок оказывается победителем")
}
