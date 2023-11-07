# Домашнее Задание - 6
## 1. Реализовать по одному примеру каждого из 3-х циклов.
Происходящее в цикле - на своё усмотрение. В теле каждого цикла должна быть применена условная конструкция.
## 2. Обработчик ошибок. 
Создать enum, который переводит код ошибки сервера в соответствующее значение enum’а и печатает человекочитаемый текст ошибки в консоль. Код ошибки генерируется рандомом. (запрос для гугла - “Коды ответов от сервера”)
## 3. Детектор типов. 
Создать ассоциативный enum DataType, который содержит 4 варианта - булевый, строка, целочисленный и неопределенный. Каждый, кроме неопределенного, должен принимать значение соответствующего типа. У DataType создать инициализатор, который может работать с любым типом из вышеуказнных (должен быть 1 инициализатор принимающий 1 параметр) и при инициализации DataType устанавливать значение соответствующее входному типу. Также, входной параметр на инициализаторе - опционал. Также, в данной задаче можно пользоваться только switch, при использовании if или guard снижается балл.

# Оценка - 8

**Первое задание** - красота, оригинально, красиво, информативно, четко!

**Второе задание** - чисто технически оно выполнено. Но, конечно, есть симпотичные способы это сделать. И, например, если бы такой код мне на работе дали на PR, я бы не одобрил.
О чем речь, собственно) Вот пример более краткого и лаконичного решения второго задания:
```
enum ServerResponseCodes {
    case informational, success, redirection, clientError, serverError
    init(_ serverCode: Int) {
        switch serverCode {
            case 100..<200: self = .informational
            case 200..<300: self = .success
            case 300..<400: self = .redirection
            case 400..<500: self = .clientError
            default: self = .serverError
        }
    }

    func printServerResponse(){
        switch self {
            case .informational: print("Informational response")
            case .success: print("Successful response")
            case .redirection: print("Redirection")
            case .clientError: print("Client error")
            default: print("Server error")
        }
    }
}
```

**Третье задание** - общая логика, конечно, такая, но тут основная сложность была в создании инициализатора и детекту типа в самом инициализаторе.

Также, отдельный лайк за комменты, да, может и "хороший код не нуждается в комментариях", но чисто со стороны проверяющего, это приятно почитать как разработчик презентует и объясняет свой код 👍 


За что снижен балл:
- 2 за отсутствие инициализатора в третьем задании.
