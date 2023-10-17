//
//  Note.swift
//  Notely
//
//  Created by quest_01 on 20/09/2023.
//

import FirebaseFirestore

class Note {
    var ref: DocumentReference?
    var key: String

    var title: String = ""
    var text: String = ""
    var date: Date = Date()

    var folderID: String
    var authorID: String
    
    var isPublic: Bool = false
        
    init(folderID: String, key: String = "", authorID: String = "") {
        self.ref = nil
        self.folderID = folderID
        self.key = key
        self.authorID = authorID
    }
    
    init(title: String, text: String, key: String = "", folderID: String = "", authorID: String = "") {
        self.title = title
        self.text = text
        self.key = key
        self.authorID = authorID
        self.folderID = folderID
    }
    
    init?(snapshot: DocumentSnapshot) {
        let constants = Constants.Firebase.notesCollection.fields.self
        guard
            let value = snapshot.data(),
            let title = value[constants.title] as? String,
            let text = value[constants.text] as? String,
            let date = value[constants.date] as? Timestamp,
            let isPublic = value[constants.isPublic] as? Bool,
            let folderID = value[constants.folderID] as? String,
            let authorID = value[constants.authorID] as? String
        else { return nil }

        self.ref = snapshot.reference
        self.key = snapshot.documentID

        self.title = title
        self.text = text
        self.isPublic = isPublic
        self.date = date.dateValue()
        self.authorID = authorID
        self.folderID = folderID
    }
    
    func toAnyObject() -> [String: Any] {
        let constants = Constants.Firebase.notesCollection.fields.self
        return [
            constants.title: title,
            constants.text: text,
            constants.date: Timestamp(date: date),
            constants.isPublic: isPublic,
            constants.folderID: folderID,
            constants.authorID: authorID
        ] as [String: Any]
    }
    
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func update(with snapshot: DocumentSnapshot) {
        let constants = Constants.Firebase.notesCollection.fields.self

        guard
            let value = snapshot.data(),
            let title = value[constants.title] as? String,
            let text = value[constants.text] as? String,
            let date = value[constants.date] as? TimeInterval,
            let isPublic = value[constants.isPublic] as? Bool,
            let folderID = value[constants.folderID] as? String,
            let authorID = value[constants.authorID] as? String
        else { return }

        self.ref = snapshot.reference
        self.key = snapshot.documentID

        self.title = title
        self.text = text
        self.isPublic = isPublic
        self.date = Date(timeIntervalSince1970: date)
        self.authorID = authorID
        self.folderID = folderID
    }
}

