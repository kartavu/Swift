//
//  RegistrationViewModel.swift
//  Notely
//
//  Created by Tima Shchekochikhin on 17.09.2023.
//

import UIKit
import FirebaseAuth

class RegistrationViewModel: AutharizationViewModel {
    
    var userFirebase: UserFirebase
    
    enum InfoId {
        case login, password, name, surname, about
    }

    var cellViewModels: [CellViewModel]?

    private(set) var registration = Registration()
    
    init(userFirebase: UserFirebase) {
        let cellConstants = Strings.auth.registrationVM.editCell.self
        
        self.userFirebase = userFirebase
        
        let items: [CellViewModel] = [
            TextEditViewModel(id: InfoId.login,
                              textType: .textField,
                              title: cellConstants.title.mail,
                              value: registration.login,
                              placeholder: cellConstants.placeholder.mail,
                              delegate: self),
            TextEditViewModel(id: InfoId.password,
                              textType: .textField,
                              title: cellConstants.title.password,
                              value: registration.password,
                              placeholder: cellConstants.placeholder.password,
                              delegate: self),
            TextEditViewModel(id: InfoId.name,
                              textType: .textField,
                              title: cellConstants.title.name,
                              value: registration.name,
                              placeholder: cellConstants.placeholder.name,
                              delegate: self),
            TextEditViewModel(id: InfoId.surname,
                              textType: .textField,
                              title: cellConstants.title.surname,
                              value: registration.surname,
                              placeholder: cellConstants.placeholder.surname,
                              delegate: self),
            TextEditViewModel(id: InfoId.about,
                              textType: .textView,
                              title: cellConstants.title.about,
                              value: registration.about,
                              placeholder: cellConstants.placeholder.about,
                              delegate: self)

        ]
        
        cellViewModels = items
    }
}

extension RegistrationViewModel: TextEditViewModelDelegate {
    func textChanged(id: Any, newText: String) {
        guard let id = id as? InfoId else { return }
        switch id {
        case .login:
            registration.login = newText
        case .password:
            registration.password = newText
        case .name:
            registration.name = newText
        case .surname:
            registration.surname = newText
        case .about:
            registration.about = newText
        }
    }
}

extension RegistrationViewModel {
    func authorization(vc: UIViewController) {
        Auth.auth().createUser(withEmail: registration.login, password: registration.password) { [weak self] user, error in
            guard let self = self else { return }
            if error == nil {
                let regInfo = self.registration
                let userInfo = ProfileInfo(name: regInfo.name, surname: regInfo.surname, about: regInfo.about)
                
                userFirebase.pushUser(userInfo)
                userFirebase.user = userInfo
                userFirebase.login()

                vc.navigationController?.popViewController(animated: true)                
            } else {
                print("Error in createUser: \(error?.localizedDescription ?? "")")
            }
        }
    }
}
