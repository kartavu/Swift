//
//  ViewController.swift
//  Homework-10
//
//  Created by Миша Кацуро on 27.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLabel()
        emailLabel()
        emailField()
        passwordLabel()
        passwordTextField()
        loginButton()
        line()
        accountLabel()
        signButton()
//        secondTaskButton()
    }
    
    func loginLabel() {
        let login = UILabel(frame: CGRect(x: 170, y: 120, width: 200, height: 20))
        
        view.addSubview(login)
        
        login.text = "LOGIN"
        login.font = UIFont.systemFont(ofSize: 22)
        login.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    func emailLabel() {
        let email = UILabel(frame: CGRect(x: 20, y: 200, width: 200, height: 20))
        
        view.addSubview(email)
        
        email.text = "email"
        email.font = UIFont.boldSystemFont(ofSize: 15)
        email.font = UIFont.systemFont(ofSize: 22)
    }
    
    func emailField() {
        let emailField = UITextField(frame: CGRect(x: 20, y: 230, width: 350, height: 30))
        
        view.addSubview(emailField)
        
        emailField.backgroundColor = .systemGray5
        emailField.textAlignment = .left
        emailField.borderStyle = .bezel
        emailField.autocapitalizationType = .none
        emailField.font = UIFont.boldSystemFont(ofSize: 19)
        emailField.font = UIFont.systemFont(ofSize: 15)
        emailField.minimumFontSize = 17
        emailField.adjustsFontSizeToFitWidth = true
    }
    
    func passwordLabel() {
        let passwordLabel = UILabel(frame: CGRect(x: 20, y: 280, width: 200, height: 20))
        
        view.addSubview(passwordLabel)
        
        passwordLabel.text = "password"
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 15)
        passwordLabel.font = UIFont.systemFont(ofSize: 22)
    }
    
    func passwordTextField() {
        let passwordTextField = UITextField(frame: CGRect(x: 20, y: 310, width: 350, height: 30))
        
        view.addSubview(passwordTextField)
        
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.textAlignment = .left
        passwordTextField.autocapitalizationType = .none
        passwordTextField.borderStyle = .bezel
        passwordTextField.minimumFontSize = 17
//        passwordTextField.adjustsFontSizeToFitWidth = .random()
    }
    
    func loginButton() {
        let loginButton = UIButton(frame: CGRect(x: 95, y: 390, width: 200, height: 50))
        
        view.addSubview(loginButton)
        
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.backgroundColor = .yellow
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.addTarget(self, action: #selector(onCLick), for: .touchDown)
    }
    
    func line() {
        let line = UILabel(frame: CGRect(x: 20, y: 470, width: 350, height: 2))
        
        view.addSubview(line)
        
        line.backgroundColor = .black
        line.text = "_________________________________________"
    }
    
    func accountLabel() {
        let account = UILabel(frame: CGRect(x: 40, y: 475, width: 250, height: 50))
        
        view.addSubview(account)
        
        //account.backgroundColor = .black
        account.text = "Need an account?"
        account.textColor = .black
        account.font = UIFont.systemFont(ofSize: 15)
        account.font = UIFont.boldSystemFont(ofSize: 13)
    }

    func signButton() {
        let signIn = UIButton(frame: CGRect(x: 150, y: 475, width: 100, height: 50))

        view.addSubview(signIn)
        signIn.setTitle("Sign In", for: .normal)
        
        signIn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signIn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        signIn.setTitleColor(.black, for: .normal)
    }
    
    @objc func onCLick() {
        let secondTask = self.storyboard?.instantiateViewController (withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondTask, animated: true)
    }
}


