//
//  SecondViewController.swift
//  Homework-10
//
//  Created by Миша Кацуро on 27.06.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createlabel()
        createbutton()
        createtext()
        
        let duckGIf = UIImage.gifImageWithName("Lol") // ставлю гифку утки
        gifImage.image = duckGIf
    }
    
    var label: UILabel!
    var button: UIButton!
    var text: UITextView!
    
    let firstValue = true
    let secondValue = false
    let thirdValue = false
    let forthValue = true
    let fifthValue = true
    let sixthValue = false
    let seventhValue = false
    
    func createlabel() {
        
        label = UILabel(frame: CGRect(x: 70, y: 50, width: 250, height: 100))
        view.addSubview(label)
        
        label.text = "Здравствуйте, пользователь"
        //        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        if (firstValue == true) { // если будет false, то будет выведен верхний текст, а так выводиться текст, который ниже
            label.text = "Приветствую вас, пользователь"
        }
    }
    
    func createbutton() {
        
        button = UIButton(frame: CGRect(x: 125, y: 770, width: 150, height: 50))
        
        view.addSubview(button)
        
        button.setTitle("Изменение фона", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.titleLabel?.numberOfLines = 0
        
        if (secondValue == false) { // если будет true, то кнопка вообще работать не будет
            button.addTarget(self, action: #selector (firstClick), for: .touchUpInside) //когда отпустил кнопку, меняет фон на красный и удаляется textView
            button.addTarget(self, action: #selector (thirdClick), for: .touchDown) // когда нажал на кнопку, то фон зеленый
            
            if (thirdValue == false) { // если false, то при отпускании кнопки, мы меняем фон на оранжевый и удаляется textView
                button.addTarget(self, action: #selector (secondClick), for: .touchUpInside)
            }
            
            if (forthValue == true) { // если true то у нас в label меняется текст и сдвигается
                button.addTarget(self, action: #selector (duckClick), for: .touchUpInside)
            }
        }
    }
    
    @objc func firstClick() {
        view.backgroundColor = .systemRed
        text.removeFromSuperview()
    }
    
    @objc func secondClick() {
        view.backgroundColor = .orange
        text.removeFromSuperview()
    }
    
    @objc func thirdClick() {
        view.backgroundColor = .green
    }
    
    @objc func duckClick() {
        if (sixthValue == false) { // если false снова меняем наш label и сдвигаем
            label.text = "Если вам нравится гифка, то оставте switch включенным, если нет, то выключите его"
            label.frame = CGRect(x: 80, y: 150, width: 250, height: 100)
            label.font = UIFont.systemFont(ofSize: 24)
            label.font = UIFont.boldSystemFont(ofSize: 20)
            
        }
    }
    
    func createtext() {
        
        text = UITextView(frame: CGRect(x: 20, y: 180, width: 350, height: 30))
        
        view.addSubview(text)
        
        text.backgroundColor = .yellow
        text.textAlignment = .left
        text.autocapitalizationType = .none
        
    }
    
    @IBAction func swich(_ sender: UISwitch) {
        if (fifthValue == true) { // если у нас вкл на slider, label меняется
            if (sender.isOn == true) {
                label.text = "Нравится гифка утки"
                
            }
            else { // если у нас выкл на switch, label меняется
                label.text = "Не нравится гифка утки"
            }
        }
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var gifImage: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func textAction(_ sender: Any) {
        if (seventhValue == false) { // меняем на slidere текст и если двигаем слайдер, то на textField будет выведено в цифрах на сколько у нас продивут slider, но для этого надо тыкнуть на textField  икогда двигаешь slider надо держать кнопку под esc(находиться слево от единицы), ну и меняется сам цвет slider
            slider.tintColor = .yellow
            textField.text! = "\(slider.value)"
        }
        
        else {
            slider.tintColor = .black
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
    }
}

