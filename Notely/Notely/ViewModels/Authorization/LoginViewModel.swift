//
//  AutharizationViewModel.swift
//  Notely
//
//  Created by Tima Shchekochikhin on 17.09.2023.
//

import UIKit
import FirebaseAuth

class LoginViewModel: AutharizationViewModel {
    
    var userFirebase: UserFirebase
    
    var cellViewModels: [CellViewModel]?
    
    enum InfoId {
        case login, password
    }
    
    private(set) var autharization = Authrazation()

    init(userFirebase: UserFirebase) {
        let cellConstants = Strings.auth.autharizationVM.editCell.self

        self.userFirebase = userFirebase

        let items: [CellViewModel] = [
            TextEditViewModel(id: InfoId.login,
                              textType: .textField,
                              title: cellConstants.title.mail,
                              value: autharization.login,
                              placeholder: cellConstants.placeholder.mail,
                              delegate: self),
            TextEditViewModel(id: InfoId.password,
                              textType: .textField,
                              title: cellConstants.title.password,
                              value: autharization.password,
                              placeholder: cellConstants.placeholder.password,
                              delegate: self)
        ]
        cellViewModels = items
    }
}

extension LoginViewModel: TextEditViewModelDelegate {
    func textChanged(id: Any, newText: String) {
        guard let id = id as? InfoId else { return }
        switch id {
        case .login:
            autharization.login = newText
        case .password:
            autharization.password = newText
        }
    }
}

extension LoginViewModel {
    func authorization(vc: UIViewController) {
        Auth.auth().signIn(withEmail: autharization.login, password: autharization.password) { [weak self] user, error in
            guard let self = self else { return }
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "Sign In Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .default))
                vc.present(alert, animated: true, completion: nil)
            } else {
                userFirebase.login()
                vc.navigationController?.popViewController(animated: true)
            }
        }
    }
}
