//
//  SourceNoteViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 29.09.2023.
//

class NoteViewModel: FirebaseViewModel {
    func getFolderName(by id: String, closure: @escaping ((String) -> ())) {
        db.collection(Constants.Firebase.foldersCollection.name).document(id).getDocument { snapshot, error in
            guard
                let snapshot = snapshot,
                let data = snapshot.data(),
                let name = data[Constants.Firebase.foldersCollection.fields.name] as? String
            else { closure(Constants.Firebase.defaultFolderName); return }
            
            closure(name)
        }
    }
    
    func getUser(by id: String, closure: @escaping ((ProfileInfo) -> ())) {
        db.collection(Constants.Firebase.usersCollection.name).document(id).getDocument { snapshot, error in
            guard
                let snapshot = snapshot,
                let info = ProfileInfo(snapshot: snapshot)
            else { return }
            
            closure(info)
        }
    }
}
