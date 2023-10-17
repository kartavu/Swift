//
//  ReusableCell.swift
//  Notely
//
//  Created by Данил Соколов on 14.09.2023.
//

protocol ReusableCell {
    static var cellIdentifier: String { get }
}

extension ReusableCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

