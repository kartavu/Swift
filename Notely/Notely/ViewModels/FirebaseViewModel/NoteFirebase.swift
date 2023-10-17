//
//  NoteFirebase.swift
//  Notely
//
//  Created by Данил Соколов on 28.09.2023.
//

import Foundation
import FirebaseFirestore

class NoteFirebase: FirebaseViewModel {

    var isSortByDate = true {
        didSet {
            let constants = Constants.Firebase.notesCollection.fields.self
            if isSortByDate {
                noteObserve(whereField: mainField, isEqualTo: mainValue, orderBy: constants.date, descending: !isSortByDate)
            } else {
                noteObserve(whereField: mainField, isEqualTo: mainValue, orderBy: constants.title, descending: !isSortByDate)
            }
        }
    }
    
    private var mainField: String
    private var mainValue: Any
    
    weak var updatableDelegate: Updatable?

    var notes: [Note] = [] {
        didSet {
            updatableDelegate?.update()
        }
    }
    
    var noteRef: CollectionReference {
        db.collection(Constants.Firebase.notesCollection.name)
    }
    
    var notesRefObservers = [ListenerRegistration]()

    init(mainField: String, mainValue: Any) {
        self.mainField = mainField
        self.mainValue = mainValue
        noteObserve(whereField: mainField, isEqualTo: mainValue)
    }
    
    init(public userID: String) {
        let constants = Constants.Firebase.notesCollection.fields.self

        self.mainField = constants.authorID
        self.mainValue = userID

        publicNoteObserve(forUser: userID)
    }
    
    deinit {
        removeObservers()
    }
    
    func publicNoteObserve(forUser id: String) {
        removeObservers()
        let constants = Constants.Firebase.notesCollection.fields.self

        let listener = noteRef
            .whereField(constants.authorID, isEqualTo: id)
            .whereField(constants.isPublic, isEqualTo: true)
            .addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            snapshot.documentChanges.forEach { [weak self] diff in
                guard let self = self else { return }
                switch diff.type {
                case .added:
                    if let note = Note(snapshot: diff.document) {
                        self.notes.insert(note, at: 0)
                    }
                case .modified:
                    if let index = findNoteIndex(diff.document) {
                        notes[index].update(with: diff.document)
                        updatableDelegate?.update()
                    }
                case .removed:
                    if let index = findNoteIndex(diff.document) {
                        notes.remove(at: index)
                    }
                }
            }
        }
        notesRefObservers.append(listener)

    }

    func noteObserve(whereField field: String, isEqualTo value: Any, orderBy path: String = "", descending: Bool = true) {
        removeObservers()
        let query: Query
        
        if !path.isEmpty {
            query = noteRef
                .order(by: path, descending: descending)
                .whereField(field, isEqualTo: value)
        } else {
            query = noteRef
                .whereField(field, isEqualTo: value)
        }
        
        let listener = query.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            snapshot.documentChanges.forEach { [weak self] diff in
                guard let self = self else { return }
                switch diff.type {
                case .added:
                    if let note = Note(snapshot: diff.document) {
                        self.notes.insert(note, at: 0)
                    }
                case .modified:
                    if let index = findNoteIndex(diff.document) {
                        notes[index].update(with: diff.document)
                        updatableDelegate?.update()
                    }
                case .removed:
                    if let index = findNoteIndex(diff.document) {
                        notes.remove(at: index)
                    }
                }
            }
        }
        notesRefObservers.append(listener)
    }
        
    func pushNote(_ note: Note) {
        noteRef.addDocument(data: note.toAnyObject())
    }
    
    func updateNote(_ note: Note) {
        note.ref?.updateData(note.toAnyObject())
    }

    func deleteNote(_ note: Note) {
        note.ref?.delete()
    }
    
    func change(folderID: String, in note: Note) {
        note.folderID = folderID
        note.ref?.updateData([Constants.Firebase.notesCollection.fields.folderID: folderID])
    }
    
    func union() {
        let constants = Constants.Firebase.notesCollection.fields.self

        if let deviceID = UIDevice.current.identifierForVendor?.uuidString,
           let userID = currentUserId {
            noteRef
                .whereField(constants.authorID, isEqualTo: deviceID)
                .getDocuments { snapshot, error in
                    guard let snapshot = snapshot else { return }
                    for document in snapshot.documents {
                        document.reference.updateData([constants.authorID: userID])
                        
                        if let folderID = document.data()[constants.folderID] as? String,
                           folderID == deviceID {
                            document.reference.updateData([constants.folderID: userID])
                        }
                    }
                }
        }
        mainValue = currentUserId as Any
        noteObserve(whereField: mainField, isEqualTo: mainValue)
    }

    func removeObservers() {
        notesRefObservers.forEach { $0.remove() }
        notesRefObservers = []
        
        notes.removeAll()
    }
    
    func returnObservers() {
        noteObserve(whereField: mainField, isEqualTo: mainValue)
    }

    private func findNoteIndex(_ snapshot: QueryDocumentSnapshot) -> Int? {
        return notes.firstIndex { snapshot.documentID == $0.key }
    }
}
