//
//  FolderCellViewModelType.swift
//  Notely
//
//  Created by Masha on 24.09.2023.
//

import Foundation

protocol FolderCellViewModelType: AnyObject {
    var name: String { get }
    var content: [Note] { get }
}
