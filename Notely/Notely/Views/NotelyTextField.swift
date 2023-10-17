//
//  NotelyTextField.swift
//  Notely
//
//  Created by Данил Соколов on 15.09.2023.
//

import UIKit

class NotelyTextField: UITextField {
    
    let padding = Constants.NotelyTextField.padding

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    private func setupTextField() {
        layer.cornerRadius = Constants.NotelyTextField.cornerRadius
        layer.borderWidth = Constants.NotelyTextField.borderWidth
        layer.borderColor = Constants.NotelyTextField.borderColor
        
        backgroundColor = Constants.NotelyTextField.bgColor
        font = UIFont.systemFont(ofSize: Constants.NotelyTextField.fontSize)
        autocapitalizationType = .none
    }
}
