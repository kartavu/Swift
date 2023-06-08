var i: Int = 11
var b: Int = 0
var a: Int = 0

// В for создается 3 рандомных числа b в диапазоне от 1 до 100
print("Рандомные чиcла:")
for _ in 1...1 {
    b = Int.random(in: 1...100)
    print("Число b:", b)
    a = Int.random(in: 1...50)
    print("Число a:", a)
    i = Int.random(in: 1...25)
    print("Число i:", i)
}

// Если созданное в for i окажется меньше 15, то к i будет прибавляться 2, пока i не будет меньше 15
while i < 15{
    i = i + 2
    print("Измененное число i:", i)
}

// Если созданное в for а окажется меньше 33, то к а будет прибавляться 2, пока оно не будет меньше 33
repeat {
    a += 2
    print("Измененное число a:", a)
} while a < 33

// 2 Задание
print()

var mistake: Int = 0

enum Mistake {
    
    case ok
    case created
    case accepted
    case nonAuthoritativeInformation
    case noContent
    case resetContent
    case partialContent
}

for _ in 1...1 {
    mistake = Int.random(in: 200...206)
    print("Ошибки:",mistake)
}

if mistake == 200 {
    let ok = Mistake.ok
    print("Расшифровка ошибки 200: Запрос успешно обработан")
}

else if mistake == 201 {
    let created = Mistake.created
    print("Расшифровка ошибки 201: Запрос успешно выполнен и в результате был создан ресурс")
}
    
else if mistake == 202 {
    let accepted = Mistake.accepted
    print("Расшифровка ошибки 202: Запрос принят, но ещё не обработан")
}
    
else if mistake == 203 {
    let nonAuthoritativeInformation = Mistake.nonAuthoritativeInformation
    print("Расшифровка ошибки 203: Этот код ответа означает, что информация, которая возвращена, была предоставлена не от исходного сервера, а из какого-нибудь другого источника")
}
    
else if mistake == 204 {
    let noContent = Mistake.noContent
    print("Расшифровка ошибки 204: Нет содержимого для ответа на запрос, но заголовки ответа, которые могут быть полезны, присылаются")
}
    
else if mistake == 205 {
    let resetContent = Mistake.resetContent
    print("Расшифровка ошибки 205: Этот код присылается, когда запрос обработан, чтобы сообщить клиенту, что необходимо сбросить отображение документа, который прислал этот запрос")
}
    
else if mistake == 206 {
    let partialContent = Mistake.partialContent
    print("Расшифровка ошибки 206: Этот код ответа используется, когда клиент присылает заголовок диапазона, чтобы выполнить загрузку отдельно, в несколько потоков")
}

// 3 задание
print()

enum DataType{
    case intType(Int)
    case boolType(Bool)
    case stringType(String)
    case nilType(Float??)
}
// если тут изменить чему равняется  DataType на любой другой case, находящийся в нем, то в switch он будет выводить этот тип
var dataType: DataType = .stringType("N")
     
switch dataType{
    
case .intType:
    print("Это целочисленная переменная")
    
case .boolType:
    print("Это булевая переменная")
    
case .stringType:
    print("Это строчная переменная")
    
case .nilType:
    print("Это неопределенная переменная")
default:
    print("Переменной не существует")
}
