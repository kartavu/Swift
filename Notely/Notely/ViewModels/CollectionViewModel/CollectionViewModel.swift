//
//  CollectionViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 28.09.2023.
//

import UIKit

protocol CollectionViewModel {
    var layout: UICollectionViewFlowLayout { get }
    
    func numberOfItemsInSection() -> Int
    
    func getNumberOfElements() -> String
    
    func textLabelNubmerViews(_ count: Int) -> String
}

extension CollectionViewModel {
    func textLabelNubmerViews(_ count: Int) -> String {
        let declension = Strings.main.mainVC.self
        
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        switch lastDigit {
        case 1:
            if lastTwoDigits != 11 {
                return declension.oneNote
            }
        case 2...4:
            if lastTwoDigits < 12 || lastTwoDigits > 14 {
                return declension.twoNote
            }
        default:
            break
        }
        return declension.manyNote
    }
}
