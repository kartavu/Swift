# Оценка - 9 баллов

Хорошая работа, молодец. Единственное, что можно улучшить:

В данной программе _name_, _age_, _status_ не изменяются, а потому, должны быть объявлены как **let**
```
class User {
    var name: String?
    var age: Int
    var status: String?
    
    init(name: String?, age: Int, status: String?) {
        self.name = name
        self.age = age
        self.status = status
    }
}
```

За что снижены баллы:
- 1 балл за срок сдачи.
