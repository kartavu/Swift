//
//  MainViewModel.swift
//  Notely
//
//  Created by Masha on 21.09.2023.
//

import Foundation
import UIKit

class MainViewModel {
    
    var isModeNotes = true {
        didSet {
            if isModeNotes {
                collectionViewModel = noteCollection
            } else {
                collectionViewModel = folderCollection
            }
        }
    }
    
    private(set) var collectionViewModel: CollectionViewModel?
    
    private(set) var noteCollection = NoteCollectionViewModel()
    private(set) var folderCollection = FolderCollectionViewModel()

    init() {
        collectionViewModel = noteCollection
    }
    
    func getNotesCount() -> Int {
        return noteCollection.firebaseNotes.notes.count
    }
    
    func getFoldersCount() -> Int {
        return folderCollection.firebaseFolders.folders.count
    }
    
    func getNotes() -> [Note] {
        return noteCollection.firebaseNotes.notes
    }
    
    func getFolders() -> [Folder] {
        return folderCollection.firebaseFolders.folders
    }
    
    func noteCellViewModel(indexPath: IndexPath) -> NoteCellViewModelType? {
        let note = noteCollection.firebaseNotes.notes[indexPath.item]
        return NoteCellViewModel(note: note)
    }
    
    func folderCellViewModel(indexPath: IndexPath) -> FolderCellViewModelType? {
        let folder = folderCollection.firebaseFolders.folders[indexPath.item]
        return FolderCellViewModel(folder: folder)
    }
            
    func numberOfItemsInSection() -> Int {
        collectionViewModel?.numberOfItemsInSection() ?? 0
    }
    
    func listLayout() -> UICollectionViewFlowLayout {
        collectionViewModel?.layout ?? UICollectionViewFlowLayout()
    }    
}
