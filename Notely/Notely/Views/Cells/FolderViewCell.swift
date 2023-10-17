//
//  NoteViewFolder.swift
//  Notely
//
//  Created by quest_01 on 22/09/2023.
//

import UIKit

class FolderViewCell: UICollectionViewCell {
    
    // MARK: - Private methods
    
    private let folderImage = UIImageView()
    private let titleFolder = UILabel()
    private let numberOfNotes = UILabel()
    private let optionsIcon = UIImageView()
    
    var isFolder = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure

    func configureCell(with folder: Folder) {
        titleFolder.text = folder.name
        numberOfNotes.text = String(folder.noteFirebase.notes.count)
    }
    
    // MARK: - Private methods
    
    private func configure() {
        configureView()
        configureFolderImage()
        configuretTitleFolder()
        configureNumberOfNotes()
        configureOptionsIcon()
        makeConstraints()
    }
    
    private func configureView() {
        backgroundColor = Constants.CollectionView.FolderCell.folderView.color
        layer.cornerRadius = Constants.CollectionView.FolderCell.folderView.cornerRadius
        layer.masksToBounds = true
    }
    
    private func configureFolderImage() {
        addSubview(folderImage)
        
        folderImage.image = UIImage(systemName: Constants.CollectionView.FolderCell.folderImage.imageName)
        folderImage.tintColor = Constants.CollectionView.FolderCell.folderImage.color
    }
    
    private func configuretTitleFolder() {
        addSubview(titleFolder)
        
        titleFolder.textAlignment = .left
        titleFolder.font = Constants.CollectionView.FolderCell.titleFolder.font
        titleFolder.textColor = Constants.CollectionView.FolderCell.titleFolder.color
        titleFolder.numberOfLines = Constants.CollectionView.FolderCell.titleFolder.numberOfLines
    }
    
    private func configureNumberOfNotes() {
        addSubview(numberOfNotes)
        
        numberOfNotes.textAlignment = .left
        numberOfNotes.font = Constants.CollectionView.FolderCell.numberOfNotes.font
        numberOfNotes.textColor = Constants.CollectionView.FolderCell.numberOfNotes.color
    }

    private func configureOptionsIcon() {
        addSubview(optionsIcon)
        
        optionsIcon.image = UIImage(systemName: Constants.CollectionView.FolderCell.optionsIcon.imageName)
        optionsIcon.tintColor = Constants.CollectionView.FolderCell.optionsIcon.color
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        makeFolderImageConstraints()
        makeOptionsIconConstraints()
        makeNumberOfNotesConstraints()
        makeTitleFolderConstraints()
    }
    
    private func makeFolderImageConstraints() {
        let folderImageConstraints = Constants.CollectionView.FolderCell.folderImage.self
        
        folderImage.snp.makeConstraints { make in
            make.height.width.equalTo(folderImageConstraints.size)
            make.top.equalToSuperview().offset(folderImageConstraints.topOffset)
            make.leading.equalToSuperview().offset(folderImageConstraints.leading)
        }
    }
    
    private func makeOptionsIconConstraints() {
        let optionsIconConstraints = Constants.CollectionView.FolderCell.optionsIcon.self
        
        optionsIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(optionsIconConstraints.topOffset)
            make.trailing.equalToSuperview().offset(optionsIconConstraints.trailing)
        }
    }
    
    private func makeTitleFolderConstraints() {
        let titleFolderConstraints = Constants.CollectionView.FolderCell.titleFolder.self
        
        titleFolder.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(titleFolderConstraints.leading)
            make.trailing.equalToSuperview().offset(titleFolderConstraints.trailing)
            make.bottom.equalTo(numberOfNotes.snp.top).offset(titleFolderConstraints.bottomOffset)
        }
    }
    
    private func makeNumberOfNotesConstraints() {
        let numberOfNotesConstraints = Constants.CollectionView.FolderCell.numberOfNotes.self
        
        numberOfNotes.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(numberOfNotesConstraints.leading)
            make.bottom.equalToSuperview().offset(numberOfNotesConstraints.bottomOffset)
        }
    }
}
