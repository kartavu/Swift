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
