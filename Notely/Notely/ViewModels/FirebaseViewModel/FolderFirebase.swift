//
//  FolderFirebase.swift
//  Notely
//
//  Created by Данил Соколов on 28.09.2023.
//

import Foundation
import FirebaseFirestore

class FolderFirebase: FirebaseViewModel {
    
    weak var updatableDelegate: Updatable?
    
    private(set) var folders = [Folder]() {
        didSet {
            updatableDelegate?.update()
        }
    }
    
    private var folderRef: CollectionReference {
        db.collection(Constants.Firebase.foldersCollection.name)
    }
    
    private var folderRefObservers = [ListenerRegistration]()
    
    init() {
        addDefaultFolder()
        folderObserve()
    }
    
    deinit {
        folderRefObservers.forEach { $0.remove() }
        folderRefObservers = []
    }
    
    func folderObserve() {
        removeObservers()
        let constants = Constants.Firebase.foldersCollection.fields.self
        let listener = folderRef
            .whereField(constants.authorID, isEqualTo: currentUserId as Any)
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else { return }
                snapshot.documentChanges.forEach { [weak self] diff in
                    guard let self = self else { return }
                    switch diff.type {
                    case .added:
                        if let folder = Folder(snapshot: diff.document) {
                            self.folders.append(folder)
                        }
                    case .modified:
                        if let index = findFolderIndex(diff.document) {
                            self.folders[index].update(with: diff.document)
                        }
                    case .removed:
                        if let index = findFolderIndex(diff.document) {
                            self.folders.remove(at: index)
                        }
                    }
                }
            }
        folderRefObservers.append(listener)
    }
    
    func pushFolder(_ folder: Folder) {
        folderRef.addDocument(data: folder.toAnyObject())
    }
    
    func union() {
        let constants = Constants.Firebase.foldersCollection.fields.self
        if let deviceID = UIDevice.current.identifierForVendor?.uuidString,
           let userID = currentUserId {
            folderRef
                .whereField(constants.authorID, isEqualTo: deviceID)
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else { return }
                    for document in snapshot.documents {
                        document.reference.updateData([constants.authorID: userID])
                    }
                }
        }
        folderObserve()
    }
    
    private func findFolderIndex(_ snapshot: QueryDocumentSnapshot) -> Int? {
        return folders.firstIndex { snapshot.documentID == $0.key }
    }
    
    func removeObservers() {
        folderRefObservers.forEach { $0.remove() }
        folderRefObservers = []
        
        folders.removeAll()
        addDefaultFolder()
    }
    
    func returnObservers() {
        folderObserve()
    }
    
    private func addDefaultFolder() {
        guard let userID = currentUserId else { return }
        let folder = Folder(name: Constants.Firebase.defaultFolderName, key: userID, authorID: userID)
        folders.append(folder)
    }
}
