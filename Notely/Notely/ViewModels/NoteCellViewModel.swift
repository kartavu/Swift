//
//  NoteCellViewModel.swift
//  Notely
//
//  Created by Masha on 21.09.2023.
//

import Foundation

class NoteCellViewModel: NoteCellViewModelType {
    
    private var note: Note
    
    var name: String {
        return note.title
    }
    
    var content: String  {
        return note.text
    }
    
    var date: Date {
        return note.date
    }
    
    var folderName: String {
        return note.folderID
    }
    
    
    var isPublic: Bool {
        note.isPublic
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    //еще  добавить название папки, имя юзера, публичная или нет
    
    init(note: Note) {
        self.note = note
    }
    
}
