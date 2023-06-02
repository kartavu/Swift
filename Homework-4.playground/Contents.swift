class JapanCar {
    var model: String = ""
    var price: Int = 0
    var enginePower: Int
    init(model: String, price: Int, enginePower: Int){
        self.model = model
        self.price = price
        self.enginePower = enginePower
    }
    func car(to model: JapanCar){
        print((model.model), "This is a good off-road car") //// Это инкапсуляция
    }
    
    func complectation(to model: JapanCar){
        var luxury: Int = 69000
        price = luxury + enginePower // Это инкапсуляция
    }
}

class LuxuryJapanCar: JapanCar {
    
    //Это наследие
    override init(model: String, price: Int, enginePower: Int){
        super.init(model: model, price: price, enginePower: enginePower)
        
    }
    
    override func car(to model: JapanCar) {
        print((model.model), "This is a luxury off-road car")// Это инкапсуляция
    }
}
let landCruiser = JapanCar(model: "Land Cruiser 200", price: 86940, enginePower: 340)
let lexus = LuxuryJapanCar(model: "Lexus 570", price: 124100, enginePower: 360)

landCruiser.car(to: landCruiser)
lexus.car(to: lexus)

func wheelDiametr(to model: JapanCar){
    print((model.model), "Диаметр колес 21")
}
wheelDiametr(to: landCruiser) // Это полиморфизм
wheelDiametr(to: lexus) // Это полиморфизм

