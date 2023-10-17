//
//  NotelyTextView.swift
//  Notely
//
//  Created by Данил Соколов on 15.09.2023.
//

import UIKit

class NotelyTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        sizeToFit()
        contentInset = Constants.NotelyTextView.padding
        layer.borderWidth = Constants.NotelyTextField.borderWidth
        layer.cornerRadius = Constants.NotelyTextField.cornerRadius
        layer.borderColor = Constants.NotelyTextField.borderColor
        backgroundColor = Constants.NotelyTextField.bgColor
        font = UIFont.systemFont(ofSize: Constants.NotelyTextField.fontSize)
        clipsToBounds = true
    }
}
