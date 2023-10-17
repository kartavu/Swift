//
//  NoteViewCell.swift
//  Notely
//
//  Created by quest_01 on 20/09/2023.
//

import UIKit

protocol NoteViewCellDelegate: AnyObject {
    func optionsIconTapped(cell: UICollectionViewCell)
}

class NoteViewCell: UICollectionViewCell {
    
    weak var delegate: NoteViewCellDelegate?
    
    // MARK: - Private methods
    
    private let previewTitleNote = UILabel()
    private let networkImageView = UIImageView()
    var optionsIcon = UIButton()
    
    private let previewTextNote = UILabel()
    
    private var noteSource = NoteSourceView()
    private let dateCreatedNote = UILabel()
    
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
        
    func configureCell(with note: Note) {
        previewTitleNote.text = note.title
        previewTextNote.text = note.text
        dateCreatedNote.text = note.dateToString()
        noteSource.setNote(note)
        networkImageView.isHidden = !note.isPublic
    }
    
    override func prepareForReuse() {
        noteSource.clearView()
    }
    
    // MARK: - Private methods
    
    private func configure() {
        configureView()
        configureStackView()
        configurePreviewTitleNote()
        configureNetworkImageView()
        configureOptionsIcon()
        configurePreviewTextNote()
        configureDateCreatedNote()
        makeConstraints()
    }
    
    private func configureView() {
        backgroundColor = Constants.CollectionView.NoteCell.noteView.color
        layer.cornerRadius = Constants.CollectionView.NoteCell.noteView.cornerRadius
        layer.masksToBounds = true
        
        addSubview(noteSource)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 6
    }
    
    private func configurePreviewTitleNote() {
        stackView.addArrangedSubview(previewTitleNote)
        previewTitleNote.textAlignment = .left
        previewTitleNote.font = Constants.CollectionView.NoteCell.previewTitle.font
        previewTitleNote.textColor = Constants.CollectionView.NoteCell.previewTitle.color
        previewTitleNote.numberOfLines = Constants.CollectionView.NoteCell.previewTitle.numberOfLines
    }
    
    private func configurePreviewTextNote() {
        addSubview(previewTextNote)
        
        previewTextNote.textAlignment = .left
        previewTextNote.font = Constants.CollectionView.NoteCell.previewText.font
        previewTextNote.textColor = Constants.CollectionView.NoteCell.previewText.color
        previewTextNote.numberOfLines = Constants.CollectionView.NoteCell.previewText.numberOfLines
    }
    
    private func configureDateCreatedNote() {
        addSubview(dateCreatedNote)
        
        dateCreatedNote.textAlignment = .right
        dateCreatedNote.font = Constants.CollectionView.NoteCell.dateCreated.font
        dateCreatedNote.textColor = .lightGray
        dateCreatedNote.adjustsFontSizeToFitWidth = true
        dateCreatedNote.minimumScaleFactor = Constants.CollectionView.NoteCell.dateCreated.minimumScaleFactor
    }
    
    private func configureOptionsIcon() {
        stackView.addArrangedSubview(optionsIcon)
        optionsIcon.setImage(UIImage(systemName: Constants.CollectionView.NoteCell.optionsIcon.imageName), for: .normal)
        optionsIcon.tintColor = Constants.CollectionView.NoteCell.optionsIcon.color
        
        optionsIcon.addTarget(self, action: #selector(optionsIconTapped), for: .touchUpInside)
    }
    
    private func configureNetworkImageView() {
        stackView.addArrangedSubview(networkImageView)
        
        networkImageView.contentMode = .scaleAspectFit
        networkImageView.image = UIImage(named: "network")
        networkImageView.tintColor = .lightGray
        
    }
    
    @objc private func optionsIconTapped() {
        delegate?.optionsIconTapped(cell: self)
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        makePreviewTitleNoteConstraints()
        makeNetworkImageViewConstraints()
        makeOptionsIconConstraints()

        makePreviewTextNoteConstraints()
        makeDateCreatedNoteConstraints()

        makeSourceViewConstrains()
        makeStackViewConstraints()
    }
    
    private func makeStackViewConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func makePreviewTitleNoteConstraints() {
        previewTitleNote.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }
    
    private func makePreviewTextNoteConstraints() {
        let previewTextNoteConstants = Constants.CollectionView.NoteCell.previewText.self
        
        previewTextNote.snp.makeConstraints { make in
            make.top.equalTo(previewTitleNote.snp.bottom).offset(previewTextNoteConstants.topOffset)
            make.trailing.equalTo(-16)
            make.leading.equalTo(previewTitleNote)
            make.bottom.equalTo(noteSource.snp.top)
        }
    }
    
    private func makeDateCreatedNoteConstraints() {
        let dateCreatedNoteConstants = Constants.CollectionView.NoteCell.dateCreated.self
        
        dateCreatedNote.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.bottom.equalToSuperview().offset(dateCreatedNoteConstants.bottomOffset)
        }
    }
    
    private func makeSourceViewConstrains() {
        noteSource.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(dateCreatedNote.snp.bottom)
//            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(16)
        }
    }
    
    private func makeOptionsIconConstraints() {
        let optionsIconConstants = Constants.CollectionView.NoteCell.optionsIcon.self
        
        optionsIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    private func makeNetworkImageViewConstraints() {
        networkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(previewTitleNote)
            make.width.height.equalTo(24)
        }
    }
}

