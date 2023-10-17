//
//  CellViewModelType.swift
//  Notely
//
//  Created by Masha on 21.09.2023.
//

import Foundation

protocol NoteCellViewModelType: AnyObject {
    var name: String { get }
    var content: String { get }
    var date: Date { get }
    var folderName: String { get }
    var isPublic: Bool { get }
    func dateToString(_ date: Date) -> String
}
