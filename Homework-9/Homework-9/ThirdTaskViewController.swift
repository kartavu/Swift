//
//  ThirdTaskViewController.swift
//  Homework-9
//
//  Created by Миша Кацуро on 25.06.2023.
//

import UIKit

class ThirdTaskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        thirdButton()
        //Label()
    }

    func thirdButton() {
        let button = UIButton(frame: CGRect(x: 50, y: 25, width: 260, height: 70))
        
        view.addSubview(button)
        
        button.setTitle("Эта кнопка создана через код", for: .normal)
        
        button.backgroundColor = .green
        button.center = view.center
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.setTitleColor(.red, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        button.addTarget(self, action: #selector (Clicked), for: .touchUpInside)
        button.addTarget(self, action: #selector (Label), for: .touchUpInside)
    }
    
    @objc func Clicked() {
        view.backgroundColor = .white
    }
    
    @objc func Label() {
        let label = UILabel(frame: CGRect(x: 30, y: 170, width: 350, height: 100))
        view.addSubview(label)
        
        label.text = "Этот текст должен вылезти после нажатия на кнопку. Кроме этого текста, должен измениться фон"
       
        label.font = UIFont.systemFont(ofSize: 20)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .black
        label.backgroundColor = .cyan
        label.textAlignment = .justified
        label.numberOfLines = 0
    }
}
//@IBOutlet weak var firstLabel: UILabel!
//@IBOutlet weak var thirdImage: UIImageView!
//override func viewDidLoad() {
//    super.viewDidLoad()
//    @IBAction func mainButton(_ sender: UIButton)
