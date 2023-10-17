//
//  ProfileInfo.swift
//  Notely
//
//  Created by Данил Соколов on 14.09.2023.
//

import FirebaseFirestore

class ProfileInfo {
    let ref: DocumentReference?
    let key: String
    
    var name: String
    var surname: String
    var about: String
    
    init(name: String, surname: String, about: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.surname = surname
        self.about = about
    }
    
    init?(snapshot: DocumentSnapshot) {
        let infoConstant = Constants.ProfileInfo.self
        guard
            let value = snapshot.data(),
            let name = value[infoConstant.name] as? String,
            let surname = value[infoConstant.surname] as? String,
            let about = value[infoConstant.about] as? String
        else { return nil }
        
        self.ref = snapshot.reference
        self.key = snapshot.documentID
        self.name = name
        self.surname = surname
        self.about = about
    }
    
    func toAnyObject() -> [String: Any] {
        let infoConstant = Constants.ProfileInfo.self

        return [
            infoConstant.name: name,
            infoConstant.surname: surname,
            infoConstant.about: about
        ]
    }
}
