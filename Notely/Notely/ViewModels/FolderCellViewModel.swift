//
//  FolderCellViewModel.swift
//  Notely
//
//  Created by Masha on 21.09.2023.
//

import Foundation

class FolderCellViewModel: FolderCellViewModelType {
    var folder: Folder
    
    var name: String {
        return folder.name
    }
    
    var content: [Note] {
        folder.noteFirebase.notes
    }
    
    init(folder: Folder) {
        self.folder = folder
    }
}
