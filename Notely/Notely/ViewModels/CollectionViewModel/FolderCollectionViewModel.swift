//
//  FolderCollectionViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 28.09.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FolderCollectionViewModel: CollectionViewModel {
    func getNumberOfElements() -> String {
        let count = numberOfItemsInSection()
        let result = String(count) + " " + Strings.main.mainVC.folders + textLabelNubmerViews(count)
        return result
    }

    var firebaseFolders = FolderFirebase()
    
    var layout: UICollectionViewFlowLayout = FolderListLayout()
    
    func numberOfItemsInSection() -> Int {
        firebaseFolders.folders.count
    }
}
