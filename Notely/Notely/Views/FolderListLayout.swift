//
//  FolderListLayout.swift
//  Notely
//
//  Created by Masha on 21.09.2023.
//

import Foundation
import UIKit

class FolderListLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        scrollDirection = .vertical
    
        minimumLineSpacing = 16
        minimumInteritemSpacing = 16
        
        sectionInset.left = 16
        sectionInset.right = 16
        
        let itemsInRow = 2
        let sideInsets = sectionInset.left * 2
        let lineInsets = minimumInteritemSpacing * CGFloat(itemsInRow - 1) + sideInsets
        let otherSpace = collectionView.frame.width - lineInsets
        let cellWidth = otherSpace / CGFloat(itemsInRow)
        
        itemSize = CGSize(width: cellWidth, height: cellWidth * 0.8)
    }
}

