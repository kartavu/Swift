# Домашнее Задание - 5 
## Создать прокол User. Данный протокол должен содержать:
- Переменную с именем пользователя
- Динамическую переменную с приветствием
- 1 метод выводящий приветствие в консоль.
### Создать 2 разных класса, реализующих данный прокол. 
- У этих классов должны быть разные значения во всех вышеуказанных переменных.

### В динамической переменной формируется уникальное приветствие, в котором используется имя пользователя.


## Доработать калькулятор. Теперь каждый входной параметр должен быть опциональным, но возвращаемое значение должно быть НЕ опциональным. Во всех негативных сценариях возвращать значение 0. Класс для калькулятора можно использовать тот же самый.


## Создать любой протокол и реализующий его класс. 
В протоколе и классе должна быть одна переменная с двойным опционалом и метод, который будет разворачивать этот опционал. Для протокола нужно создать extension, в котором опционал полностью разворачивается через “дефолтные значения”. В классе нужно сделать реализацию этого же метода, но через “force-unwrap”.

# Оценка - 5

В методе division лучше не использовать forse-unwrap, а работать через "?":
```
func division(_ a: Float?, _ b: Float?) -> Float {
        if b! == 0 {
          return result
        }
        return a!/b!
    }
```

И двойной опционал выглядит вот так:
```
let someValue: Int??
```

За что снижена оценка:
- 1 балл за то что ДЗ сдана позже срока.
- 1 балл за отсутствие динамической переменной в первом задании.
- 1 балл за отсутствие метода в протоколе, который должен выводить приветствие.
- 2 балла за отсутствие двойного опционала в доп. задании. 
