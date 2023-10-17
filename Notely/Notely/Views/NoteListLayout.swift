//
//  NoteListLayout.swift
//  Notely
//
//  Created by quest_01 on 20/09/2023.
//

import UIKit

class NoteListLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        scrollDirection = .vertical
    
        minimumLineSpacing = 16
        
        let cvWidth = collectionView.bounds.width * 0.9
        let cvHeight = UIScreen.main.bounds.height
    
        let cellWidth = cvWidth
        let cellHeight = cvHeight / 6.5
        
        itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
}
