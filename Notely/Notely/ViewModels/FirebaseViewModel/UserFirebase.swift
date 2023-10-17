//
//  UserFirebase.swift
//  Notely
//
//  Created by Данил Соколов on 28.09.2023.
//

import FirebaseFirestore

protocol Unionable: AnyObject {
    func unionNotes()
}

class UserFirebase: FirebaseViewModel {
    var user: ProfileInfo?
    var userRef: CollectionReference {
        db.collection(Constants.Firebase.usersCollection.name)
    }
    
    weak var delegate: Unionable?
    
    init(closure: ((UserFirebase) -> ())) {
        login()
        closure(self)
    }
    
    func login() {
        if let userID = currentUserId {
            getUserInfo(with: userID) { [weak self] info in
                guard let self = self else { return }
                self.user = info
            }
        }
        delegate?.unionNotes()
    }

    func pushUser(_ info: ProfileInfo) {
        guard let id = currentUserId else { return }
        userRef.document(id).setData(info.toAnyObject())
    }
    
    func getUserInfo(with id: String, closure: @escaping ((ProfileInfo) -> ())) {
        userRef.document(id).getDocument { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let snapshot = snapshot,
                      let info = ProfileInfo(snapshot: snapshot)
                else { return }
                closure(info)
            }
        }
    }

    func updateProfileInfo(with profileInfo: ProfileInfo?) {
        if let id = currentUserId,
           let info = profileInfo {
            let ref = userRef.document(id)
            ref.updateData(info.toAnyObject())
        }
    }
}
