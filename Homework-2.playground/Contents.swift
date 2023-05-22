var firstText: String="Первый текст"
let secondText: String="Второй текст"

var firstNumber: Int=256
let secondNumber: Int=564

var firstFraction: Float=25.76
let secondFraction: Float=56.389

var firstStatment: Bool=true
let secondStatement: Bool=false

var calculatedFinalyNumber=Int(firstNumber)+Int(firstNumber) / 2
var secondCalculatedFinalyNumber = Int(calculatedFinalyNumber) * 2
secondCalculatedFinalyNumber /= 35

if secondCalculatedFinalyNumber <= 35{
    print(firstStatment)
}
else {
    print(secondStatement)
}

class University{
    
    
    var classesNumber: Int=0 //количество пар по предмету в одном семестре
    var averageNumber: Int=0 //среднее число походов на эту пару
    
    var weeksNumber: Int{ //количество недель, для закрытия пары
        get{
            return classesNumber / averageNumber
        }
        set(newWeeksNumber){
            self.averageNumber = classesNumber / newWeeksNumber
        }
    }
    init(classesNumber: Int, averageNumber: Int){
        self.classesNumber = classesNumber
        self.averageNumber = averageNumber
    }
}

var myUniv: University = University (classesNumber: 55, averageNumber: 2)
print (myUniv.weeksNumber)
if myUniv.weeksNumber > 17{
    print ("Не успеешь закрыть")
    
    myUniv.weeksNumber = 17
    print(String(myUniv.averageNumber) + " раза в неделю надо ходить, чтобы закрыть" ) // высчитываем при определенном количестве недель и пар, сколько раз в неделю надо сходить
}
else{
    print("Успеваешь закрыть")
    
}
