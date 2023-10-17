//
//  ProfileInfoCell.swift
//  Notely
//
//  Created by Данил Соколов on 14.09.2023.
//

import UIKit

class TextEditCell: UITableViewCell, ReusableCell {
    
    private let titleLabel: UILabel = {
        let labelConstants = Constants.ProfileEditVC.tableView.cell.label.self
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: labelConstants.fontSize)
        label.textColor = labelConstants.color
        return label
    }()
    private let infoTextField: NotelyTextField = {
        let textField = NotelyTextField()
        textField.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        return textField
    }()
    private let errorLabel: UILabel = {
        let labelConstants = Constants.ProfileEditVC.tableView.cell.label.self
        let label = UILabel()
        label.font = Constants.ProfileEditVC.tableView.cell.errorLabel.font
        label.textColor = Constants.ProfileEditVC.tableView.cell.errorLabel.textColor
        label.text = ""
        label.isHidden = true
        return label
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.ProfileEditVC.tableView.inCellSpacing
        return stack
    }()
    
    var viewModel: TextEditViewModel? {
        didSet {
            update()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeTitleConstraints()
        makeTextFieldConstraints()
        makeErrorLabelConstrains()
        makeVerticalStackConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(infoTextField)
        verticalStack.addArrangedSubview(errorLabel)
        contentView.addSubview(verticalStack)
    }
    
    private func makeVerticalStackConstrains() {
        verticalStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func makeTitleConstraints() {
        let cellConstants = Constants.ProfileEditVC.tableView.cell.self

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(cellConstants.leadingTrailingOffset)
            make.top.equalToSuperview().offset(cellConstants.label.topOffset)
        }
    }
    
    private func makeTextFieldConstraints() {
        let cellConstants = Constants.ProfileEditVC.tableView.cell.self
        infoTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(cellConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().inset(cellConstants.leadingTrailingOffset)
            make.height.equalTo(cellConstants.textField.height)
        }
    }
    
    private func makeErrorLabelConstrains() {
        let cellConstants = Constants.ProfileEditVC.tableView.cell.self
        
        errorLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(cellConstants.leadingTrailingOffset)
            make.bottom.equalToSuperview().offset(cellConstants.errorLabel.bottomOffset)
        }
    }
    
    private func update() {
        infoTextField.placeholder = viewModel?.placeholder
        infoTextField.text = viewModel?.value
        titleLabel.text = viewModel?.title
        infoTextField.delegate = self
        
        if let viewModel = viewModel {
            errorLabel.text = viewModel.error
            errorLabel.isHidden = viewModel.error.isEmpty
            if !errorLabel.text!.isEmpty {
                infoTextField.backgroundColor = Constants.ProfileEditVC.tableView.cell.textField.backgroundColorError
                infoTextField.layer.borderColor = Constants.ProfileEditVC.tableView.cell.textField.borderColorError
            } else {
                infoTextField.backgroundColor = Constants.NotelyTextField.bgColor
                infoTextField.layer.borderColor = Constants.NotelyTextField.borderColor
            }
        }
        if titleLabel.text == Strings.auth.autharizationVM.editCell.title.password {
            infoTextField.isSecureTextEntry = true
        } else {
            infoTextField.isSecureTextEntry = false
        }
    }
}

extension TextEditCell: UITextFieldDelegate {
    @objc func textFieldChange(_ textField: UITextField) {
        viewModel?.changeValue(text: textField.text ?? "")
    }
}
