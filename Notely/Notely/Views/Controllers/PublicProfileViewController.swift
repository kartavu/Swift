//
//  PublicProfileViewController.swift
//  Notely
//
//  Created by quest_01 on 20/09/2023.
//

import UIKit

class PublicProfileViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var viewModel: NoteFirebase
    
    private var profileInfo: ProfileInfo
    
    private let profileInfoView: ProfileInfoView
    
    private let noNotesLabel = UILabel()
    
    private var collectionView: UICollectionView = {
        let layout = NoteListLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    init(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        self.profileInfoView = ProfileInfoView(profileInfo: profileInfo)
        viewModel = NoteFirebase(public: profileInfo.key)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updatableDelegate = self
        
        configureView()
        addSubview()
        configureNotesCollection()
        configureNoNotesLabel()
        
        makeConstraints()
    }
    
    // MARK: - Private methods

    
    private func configureView() {
        view.backgroundColor = Constants.PublicProfile.pageView.color
    }

    private func configureNotesCollection() {
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NoteViewCell.self, forCellWithReuseIdentifier: "NoteViewCell")
    }
    
    private func addSubview() {
        view.addSubview(profileInfoView)
        view.addSubview(collectionView)
    }

    private func configureNoNotesLabel() {
        noNotesLabel.text = Strings.main.PublicProfile.labelText
        noNotesLabel.textAlignment = .center
        noNotesLabel.isHidden = true
        view.addSubview(noNotesLabel)
    }
    
    // MARK: - Constraints

    private func makeConstraints() {
        makeContainerViewConstraints()
        
        makeCollectionViewConstraints()
        makeNoNotesLabelConstraints()
    }
    
    private func makeContainerViewConstraints() {
        let containerViewConstants = Constants.PublicProfile.containerView.self
        
        profileInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(containerViewConstants.topOffset)
            make.left.equalToSuperview().offset(containerViewConstants.leftOffset)
            make.right.equalToSuperview().offset(containerViewConstants.rightOffset)
        }
    }
    
    private func makeCollectionViewConstraints() {
        let collectionViewConstants = Constants.CollectionView.self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(profileInfoView.snp.bottom).offset(collectionViewConstants.topOffset)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func makeNoNotesLabelConstraints() {
        noNotesLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource


extension PublicProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteViewCell", for: indexPath) as! NoteViewCell
        let note = viewModel.notes[indexPath.item]
        cell.configureCell(with: note)
        return cell
    }
}

extension PublicProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let note = viewModel.notes[indexPath.item]
        navigationItem.backBarButtonItem?.title = "Назад"
        let vc = NoteViewController(note: note, isNewNote: false)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PublicProfileViewController: Updatable {
    func update() {
        collectionView.reloadData()
    }
}
