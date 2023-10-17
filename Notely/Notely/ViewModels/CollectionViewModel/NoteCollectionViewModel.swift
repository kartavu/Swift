//
//  NoteCollectionViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 28.09.2023.
//

import UIKit
import FirebaseAuth

class NoteCollectionViewModel: CollectionViewModel {
    
    func getNumberOfElements() -> String {
        let count = numberOfItemsInSection()
        let result = String(count) + " " + Strings.main.mainVC.notes + textLabelNubmerViews(count)
        return result
    }
    
    var firebaseNotes: NoteFirebase
    
    init() {
        let constants = Constants.Firebase.notesCollection.fields.self

        if let userID = Auth.auth().currentUser?.uid {
            firebaseNotes = NoteFirebase(mainField: constants.authorID, mainValue: userID)
        } else {
            let userID = UIDevice.current.identifierForVendor?.uuidString
            firebaseNotes = NoteFirebase(mainField: constants.authorID, mainValue: userID)
        }
    }
    
    var layout: UICollectionViewFlowLayout = NoteListLayout()
    
    func numberOfItemsInSection() -> Int {
        firebaseNotes.notes.count
    }    
}
