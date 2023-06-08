protocol User {
    var userName: String  { get }
    var helloUser: String { get }
}

protocol AdvancedUser {
    var name: String { get }
    var surname: String { get }
    var age: Int { get }
    var hello: String { get }
}

class UserFirst: User {
    var userName: String = ""
    var helloUser: String = ""
}

class UserSecond: AdvancedUser {
    var name: String = ""
    var surname: String = ""
    var age: Int = 0
    var hello: String = ""
}

var user: UserFirst = UserFirst()
user.userName = "Mike"
user.helloUser = "Hello, my name is \(user.userName)"
print(user.helloUser)

var advancedUser: UserSecond = UserSecond()
advancedUser.name = "Phil"
advancedUser.surname = "Ostrov"
advancedUser.age = 26
advancedUser.hello = "Good morning"
print(advancedUser.name, advancedUser.surname, advancedUser.hello)

class Calculator {
    var result: Float = 0
    
    func sum(a: Float?, b: Float?)->Float {
        return a!+b!
    }
    
    func subtraction(_ a: Float?, _ b: Float?)->Float {
        return b!-a!
    }
    
    func multiplication(_ a: Float?, _ b: Float?)->Float {
        return a!*b!
    }
    
    func division(_ a: Float?, _ b: Float?)->Float {
        if b! == 0 {
          return result
        }
        return a!/b!
    }
}
let myCalculator = Calculator()
print ("Класс калькулятор: ")
print ("a + b =",myCalculator.sum(a: 0, b: 7 ))
print ("a - b =",myCalculator.subtraction(5.5, 6.3))
print ("a * b =",myCalculator.multiplication(4.256, 0))
print ("a / b =",myCalculator.division(2, 0))
print()

protocol Phone {
    var brand: String { get }
    var type: String { get }
    var model : Double? { get set }
    mutating func Model()
    
}

extension Phone {
    mutating func Model(){
        model = model ?? 0.0
    }
}

class FirstPhone: Phone {
    var brand: String = ""
    var type: String = ""
    var model: Double? = 0
    
    func forseUnwrapModel() {
        model = model!
    }
}

var mobilePhone: FirstPhone = FirstPhone()
mobilePhone.brand = "Apple"
mobilePhone.type = "iPhone"
mobilePhone.model = 12
print(mobilePhone.brand, mobilePhone.type, mobilePhone.model!)
