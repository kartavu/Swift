//
//  FirebaseViewModel.swift
//  Notely
//
//  Created by Данил Соколов on 24.09.2023.
//

import FirebaseFirestore
import FirebaseAuth
import UIKit

protocol FirebaseViewModel: AnyObject {
    var db: Firestore { get }
    var currentUserId: String? { get }
}

extension FirebaseViewModel {
    var db: Firestore {
        Firestore.firestore()
    }
    
    var currentUserId: String? {
        if let id = Auth.auth().currentUser?.uid {
            return id
        } else if let id = UIDevice.current.identifierForVendor?.uuidString {
            return id
        } else {
            return nil
        }
    }
}
