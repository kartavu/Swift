//
//  FolderNotesViewController.swift
//  Notely
//
//  Created by quest_01 on 24/09/2023.
//

import UIKit
import FirebaseFirestore

class FolderNotesViewController: UIViewController, NoteViewCellDelegate {
    
    var folderFirebase: FolderFirebase
    private let folder: Folder
    
    private var collectionView: UICollectionView = {
        let layout = NoteListLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    init(folder: Folder, firebase: FolderFirebase) {
        self.folder = folder
        self.folderFirebase = firebase
        super.init(nibName: nil, bundle: nil)
        self.folder.noteFirebase.updatableDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        navigationItem.title = folder.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        folder.noteFirebase.returnObservers()
        folderFirebase.returnObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        folder.noteFirebase.removeObservers()
        folderFirebase.removeObservers()
    }
        
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NoteViewCell.self, forCellWithReuseIdentifier: "NoteViewCell")
    }
    
    func optionsIconTapped(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        showActionSheetForNote(indexPath)
    }
    
    func deleteSelectedNote(at indexPath: IndexPath) {
        let note = folder.noteFirebase.notes[indexPath.item]
        folder.noteFirebase.deleteNote(note)
        collectionView.reloadData()
    }
    
    func showFolderSelection(indexPath: IndexPath) {
        let folderSelectionController = UIAlertController(title: "Выберите папку", message: nil, preferredStyle: .actionSheet)
        
        for folder in folderFirebase.folders {
            let selectFolderAction = UIAlertAction(title: folder.name, style: .default) { [weak self] _ in
                guard let self = self else { return }
                let note = self.folder.noteFirebase.notes[indexPath.item]
                self.folder.noteFirebase.change(folderID: folder.key, in: note)
            }
            folderSelectionController.addAction(selectFolderAction)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        folderSelectionController.addAction(cancelAction)
        
        present(folderSelectionController, animated: true, completion: nil)
    }
}

extension FolderNotesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folder.noteFirebase.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteViewCell", for: indexPath) as! NoteViewCell
        let note = folder.noteFirebase.notes[indexPath.item]
        cell.configureCell(with: note)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let note = folder.noteFirebase.notes[indexPath.item]
        navigationItem.backBarButtonItem?.title = "К списку"
        let vc = NoteViewController(note: note, isNewNote: false)
        vc.sendable = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showActionSheetForNote(_ indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: "Опции", message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black
        
        let actionDeleteNote = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.deleteSelectedNote(at: indexPath)
        }
        
        let actionSelectFolder = UIAlertAction(title: "Сменить папку", style: .default) { _ in
            self.showFolderSelection(indexPath: indexPath)
        }
        
        let title = folder.noteFirebase.notes[indexPath.item].isPublic ? "Сделать приватной" : "Сделать публичной"
        let actionPrivacyNote = UIAlertAction(title: title, style: .default) { [weak self] _ in
            guard let self = self else { return }
            let note = self.folder.noteFirebase.notes[indexPath.item]
            note.isPublic.toggle()
            self.folder.noteFirebase.updateNote(note)
        }

        let actionCancel = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        
        actionSheet.addAction(actionDeleteNote)
        actionSheet.addAction(actionSelectFolder)
        actionSheet.addAction(actionPrivacyNote)
        actionSheet.addAction(actionCancel)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension FolderNotesViewController: NoteSendable {
    func createNote(note: Note) {
        folder.noteFirebase.pushNote(note)
    }
    
    func updateNote(note: Note) {
        folder.noteFirebase.updateNote(note)
    }
}

extension FolderNotesViewController: Updatable {
    func update() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}
