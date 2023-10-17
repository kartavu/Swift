//
//  MainViewModelType.swift
//  Notely
//
//  Created by Masha on 21.09.2023.
//

import Foundation
import UIKit

protocol MainViewModelType {
    func getCellCollectionViewType(isScreenNotes: Bool) -> Bool
    func noteCellViewModel(indexPath: IndexPath) -> NoteCellViewModelType?
    func folderCellViewModel(indexPath: IndexPath) -> FolderCellViewModelType?
    func numberOfItemsInSection() -> Int
    func listLayout() -> UICollectionViewFlowLayout
    func getNotes () -> [Note]
    func getFolders() -> [Folder]
}
