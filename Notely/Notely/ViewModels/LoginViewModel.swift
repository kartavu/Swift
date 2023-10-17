//
//  AutharizationViewModel.swift
//  Notely
//
//  Created by Tima Shchekochikhin on 17.09.2023.
//

import UIKit

class LoginViewModel: AutharizationViewModel {
    
    enum InfoId {
        case login, password
    }
    
    private(set) var autharization = Authrazation()

    var cellViewModels: [CellViewModel]?
    
    init() {
        let cellConstants = Strings.auth.autharizationVM.editCell.self
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
