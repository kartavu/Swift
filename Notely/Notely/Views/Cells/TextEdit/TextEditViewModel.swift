//
//  TextEditViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 14.09.2023.
//

import UIKit

protocol TextEditViewModelDelegate: AnyObject {
    func textChanged(id: Any, newText: String)
}

class TextEditViewModel: CellViewModel {
    enum TextType {
        case textView, textField
    }
    
    var id: Any
    var textType: TextType
    
    var title: String
    var value: String
    var placeholder: String
    var error: String = ""
    
    weak var delegate: TextEditViewModelDelegate?
    
    init(id: Any, textType: TextType, title: String, value: String, placeholder: String, delegate: TextEditViewModelDelegate? = nil) {
        self.id = id
        self.textType = textType
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.delegate = delegate
    }
    
    func getCell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        switch textType {
        case .textField:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextEditCell.cellIdentifier,
                                                        for: indexPath) as? TextEditCell {
                cell.viewModel = self
                return cell
            }
        case .textView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TextViewEditCell.cellIdentifier,
                                                        for: indexPath) as? TextViewEditCell {
                cell.viewModel = self
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func changeValue(text: String) {
        delegate?.textChanged(id: id, newText: text)
    }
}
