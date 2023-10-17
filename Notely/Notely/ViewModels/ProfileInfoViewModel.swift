//
//  ProfileInfoViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 14.09.2023.
//

import UIKit

class ProfileInfoViewModel {
    
    enum InfoId {
        case name, surname, about
    }
    
    private var profileInfo: ProfileInfo?

    var cellViewModels: [CellViewModel] {
        let cellConstants = Strings.main.profileInfoVM.editCell.self
        let items: [CellViewModel] = [
            TextEditViewModel(id: InfoId.surname,
                              textType: .textField,
                              title: cellConstants.title.surname,
                              value: profileInfo?.surname ?? "",
                              placeholder: cellConstants.placeholder.surname,
                              delegate: self),
            TextEditViewModel(id: InfoId.name,
                              textType: .textField,
                              title: cellConstants.title.name,
                              value: profileInfo?.name ?? "",
                              placeholder: cellConstants.placeholder.name,
                              delegate: self),
            TextEditViewModel(id: InfoId.about,
                              textType: .textView,
                              title: cellConstants.title.about,
                              value: profileInfo?.about ?? "",
                              placeholder: cellConstants.placeholder.about,
                              delegate: self)
        ]
        return items
    }
    
    init(profileInfo: ProfileInfo?) {
        self.profileInfo = profileInfo
    }
}

extension ProfileInfoViewModel: TextEditViewModelDelegate {
    func textChanged(id: Any, newText: String) {
        guard let id = id as? InfoId else { return }
        switch id {
        case .name:
            profileInfo?.name = newText
        case .surname:
            profileInfo?.surname = newText
        case .about:
            profileInfo?.about = newText
        }
    }
}
