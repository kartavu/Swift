//
//  Folder.swift
//  Notely
//
//  Created by Данил Соколов on 24.09.2023.
//

import FirebaseFirestore

class Folder {
    var noteFirebase: NoteFirebase
    
    var ref: DocumentReference?
    var key: String

    var name: String = ""
    var authorID: String
        
    init(name: String, key: String = "", authorID: String = "") {
        self.name = name
        self.key = key
        self.authorID = authorID
        noteFirebase = NoteFirebase(mainField: Constants.Firebase.notesCollection.fields.folderID, mainValue: key)
    }
    
    init?(snapshot: DocumentSnapshot) {
        guard
            let value = snapshot.data(),
            let name = value[Constants.Firebase.foldersCollection.fields.name] as? String,
            let authorID = value[Constants.Firebase.foldersCollection.fields.authorID] as? String
        else { return nil }
        
        self.ref = snapshot.reference
        self.key = snapshot.documentID
        
        self.name = name
        self.authorID = authorID
        
        noteFirebase = NoteFirebase(mainField: Constants.Firebase.notesCollection.fields.folderID, mainValue: key)
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            Constants.Firebase.foldersCollection.fields.name: name,
            Constants.Firebase.foldersCollection.fields.authorID: authorID
        ]
    }
    
    func update(with snapshot: DocumentSnapshot) {
        guard
            let value = snapshot.data(),
            let name = value[Constants.Firebase.foldersCollection.fields.name] as? String,
            let authorID = value[Constants.Firebase.foldersCollection.fields.authorID] as? String
        else { return }
        
        self.ref = snapshot.reference
        self.key = snapshot.documentID
        
        self.name = name
        self.authorID = authorID
        
        noteFirebase = NoteFirebase(mainField: Constants.Firebase.notesCollection.fields.folderID, mainValue: key)
    }
}
