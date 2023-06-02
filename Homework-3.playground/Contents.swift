class Calculator{
    func sum(a: Float, b: Float)->Float{
        return a+b
    }
    func subtraction(_ a: Float, _ b: Float)->Float{
        return b-a
    }
    func multiplication(_ a: Float, _ b: Float)->Float{
        return a*b
    }
    func division(_ a: Float, _ b: Float)->Float{
        return a/b
    }
}
let myCalculator = Calculator()
print ("Класс калькулятор: ")
print ("a + b =",myCalculator.sum(a: 15, b: 25))
print ("a - b =",myCalculator.subtraction(5.5, 6.3))
print ("a * b =",myCalculator.multiplication(4.256, 76.9))
print ("a / b =",myCalculator.division(43.87, 4.709))
print()

class SecondTaskCalculator{
    let sum = {
        (x: Float, y: Float) -> Float in
        return x + y
    }
    let subtraction = {
        (x: Float, y: Float) -> Float in
        return x-y
    }
    let multiplication = {
        (x: Float, y: Float) -> Float in
        return x*y
    }
    let division = {
        (x: Float, y: Float) -> Float in
        return x/y
    }
}
let mySecondTask=SecondTaskCalculator()
print("Замыкание: ")
print ("a + b =",mySecondTask.sum(3, 5))
print ("a - b =",mySecondTask.subtraction(5.5, 6.3))
print ("a * b =",mySecondTask.multiplication(4.256, 76.9))
print ("a / b =",mySecondTask.division(43.87, 4.709))


    
class ThirdTaskCalculation{
    var result: Double = 0
    
    func start(with value: Double) -> ThirdTaskCalculation {
      result = result + value
        return self
    }
    func add(_ value: Double) -> ThirdTaskCalculation {
        result = result + value
        return self
    }
    func multipy(by value: Double) -> ThirdTaskCalculation {
        result = result * value
        return self
    }
    func divide(_ value: Double) -> ThirdTaskCalculation {
        result = result / value
        return self
    }
    func thirdTaskCalculation() -> Double {
        return result
    }
}
let myThirdTaskCalculation=ThirdTaskCalculation()
let result = ThirdTaskCalculation().start(with: 1).divide(3).add(2).multipy(by: 4).thirdTaskCalculation()
print(result)






