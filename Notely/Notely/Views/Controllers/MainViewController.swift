//
//  TemplateViewController.swift
//  Notely
//
//  Created by Данил Соколов on 12.09.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class MainViewController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - Private properties

    private var viewModel = MainViewModel()
    private var userViewModel: UserFirebase
    
    // MARK: - UI properties
    
    private var collectionView: UICollectionView = {
        let layout = NoteListLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.isScrollEnabled = true
        collectionView.register(NoteViewCell.self, forCellWithReuseIdentifier: "NoteViewCell")
        collectionView.register(FolderViewCell.self, forCellWithReuseIdentifier: "FolderViewCell")

        return collectionView
    }()
    
    private let noContentView = NoContentView()
    
    private let switchMenuButton: UIButton = {
        let switchMenuButton = UIButton()
        switchMenuButton.setBackgroundImage(UIImage(systemName: Constants.MainVC.switchMenuButton.imageName)?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        return switchMenuButton
    }()
    
    private let numberOfElements: UILabel = {
        let numberOfElements = UILabel()
        numberOfElements.textColor = .gray
        numberOfElements.font = UIFont.systemFont(ofSize: Constants.MainVC.numberOfElements.textOfSize)
        return numberOfElements
    }()
    
    private let personButton: UIButton = {
        let personButton = UIButton()
        personButton.setBackgroundImage(UIImage(systemName: Constants.MainVC.personButton.imageName), for: .normal)
        return personButton
    }()
    
    private let menuButton: UIButton = {
        let menuButton = UIButton()
        menuButton.setBackgroundImage(UIImage(systemName: Constants.MainVC.menuButton.imageName), for: .normal)
        return menuButton
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [Strings.main.mainVC.segmentedControlItemFirst, Strings.main.mainVC.segmentedControlItemSecond])
        segmentedControl.selectedSegmentIndex = Constants.MainVC.segmentedControl.selectedSegmentIndex
        return segmentedControl
    }()
    
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.setBackgroundImage(UIImage(systemName: Constants.MainVC.addButton.imageName), for: .normal)
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        addButton.layer.shadowOpacity = 0.4
        addButton.layer.shadowRadius = 2
        return addButton
    }()
    
    // MARK: - View circle
    
    init(userViewModel: UserFirebase) {
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewModel.folderCollection.firebaseFolders.updatableDelegate = self
        viewModel.noteCollection.firebaseNotes.updatableDelegate = self
        userViewModel.delegate = self
        
        configureView()
        configureNavigator()
        configureNotesCollection()
        addSubviews()
        addTargetsSubviews()
        makeConstraints()
        changeContentOnScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        segmentedChange()
        
        viewModel.folderCollection.firebaseFolders.returnObservers()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
        personButton.isHidden = false
        menuButton.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.noteCollection.firebaseNotes.removeObservers()
        viewModel.folderCollection.firebaseFolders.removeObservers()
        
        personButton.isHidden = true
        menuButton.isHidden = true
    }
        
    // MARK: - Private methods

    private func configureView() {
        view.backgroundColor = .white
    }

    private func configureNavigator() {
        navigationItem.title = Strings.main.appName
        navigationController?.navigationBar.addSubview(personButton)
        navigationController?.navigationBar.addSubview(menuButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.delegate = self
    }
    
    private func configureNotesCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(switchMenuButton)
        view.addSubview(numberOfElements)
        view.addSubview(noContentView)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        view.addSubview(addButton)
    }
    
    private func addTargetsSubviews() {
        personButton.addTarget(self, action: #selector(showUser), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(writeNote), for: .touchUpInside)
        switchMenuButton.addTarget(self, action: #selector(switchCollectionLayout), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
    }
    
    private func makeConstraints() {
        makePersonButtonConstraints()
        makeMenuButtonConstraints()
        makeSegmentControllerConstraints()
        makeAddButtonConstraints()
        makeSwitchMenuButtonConstraints()
        makeNumberOfElementsConstraints()
        makeCollectionViewConstraints()
    }
    
    private func changeContentOnScreen() {
        numberOfElements.text = viewModel.collectionViewModel?.getNumberOfElements()
        if viewModel.getNotes().isEmpty {
            noContentView.isHidden = false
            collectionView.isHidden = true
            switchMenuButton.isHidden = true
            numberOfElements.isHidden = true
            makeNoContentViewConstraints()
        } else {
            noContentView.isHidden = true
            if segmentedControl.selectedSegmentIndex == 0 {
                switchMenuButton.isHidden = false
            } else {
                switchMenuButton.isHidden = true
            }
            collectionView.isHidden = false
            numberOfElements.isHidden = false
            collectionView.reloadData()
        }
    }
    
    private func styleChangeSwitchButton() {
        viewModel.isModeNotes.toggle()
        
        if viewModel.isModeNotes {
            switchMenuButton.backgroundColor = .white
            switchMenuButton.setBackgroundImage(UIImage(systemName: Constants.MainVC.switchMenuButton.imageName)?
                .withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
            segmentedControl.isEnabled = true
        } else {
            switchMenuButton.backgroundColor = .systemGray
            switchMenuButton.setBackgroundImage(UIImage(systemName: Constants.MainVC.switchMenuButton.imageName)?
                .withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            segmentedControl.isEnabled = false
        }
    }

    private func showFolderSelection(indexPath: IndexPath) {
        let folderSelectionController = UIAlertController(title: "Выберите папку", message: nil, preferredStyle: .actionSheet)
        
        for folder in viewModel.getFolders() {
            let selectFolderAction = UIAlertAction(title: folder.name, style: .default) { [weak self] _ in
                guard let self = self else { return }
                let note = viewModel.getNotes()[indexPath.item]
                viewModel.noteCollection.firebaseNotes.change(folderID: folder.key, in: note)
            }
            folderSelectionController.addAction(selectFolderAction)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        folderSelectionController.addAction(cancelAction)
        
        present(folderSelectionController, animated: true, completion: nil)
    }
    
    private func deleteSelectedNote(at indexPath: IndexPath) {
        let note = viewModel.getNotes()[indexPath.item]
        
        viewModel.noteCollection.firebaseNotes.deleteNote(note)
        
        collectionView.reloadData()
        changeContentOnScreen()
    }
    
    private func showFolderNotesViewController(for folder: Folder) {
        folder.noteFirebase.isSortByDate = viewModel.noteCollection.firebaseNotes.isSortByDate
        let folderNotesViewController = FolderNotesViewController(folder: folder, firebase: viewModel.folderCollection.firebaseFolders)
        navigationItem.backBarButtonItem?.title = "Все папки"
        navigationController?.pushViewController(folderNotesViewController, animated: true)
    }
    
    // MARK: - Targets actions
    
    @objc private func showMenu() {
        let actionSheet = UIAlertController(title: Strings.main.mainVC.actionSheetTitle, message: nil, preferredStyle: .actionSheet)
        actionSheet.view.tintColor = .black
        
        let actionAddFolder = UIAlertAction(title: Strings.main.mainVC.actionAddFolderTitle, style: .default) { _ in
            self.addFolder()
        }
        
        let sortTitle = viewModel.noteCollection.firebaseNotes.isSortByDate ? Strings.main.mainVC.actionSortAlphTitle : Strings.main.mainVC.actionSortDateTitle
        let actionSort = UIAlertAction(title: sortTitle, style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.noteCollection.firebaseNotes.isSortByDate.toggle()
            self.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: Strings.main.mainVC.cancelActionTitle, style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.systemBlue, forKey: Strings.main.mainVC.cancelActionValueForKey)
        
        actionSheet.addAction(actionAddFolder)
        actionSheet.addAction(actionSort)
        actionSheet.addAction(cancelAction)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.menuButton
            popoverController.sourceRect = self.menuButton.bounds
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func addFolder() {
        let alertController = UIAlertController(title: Strings.main.mainVC.alertControllerTitle, message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = Strings.main.mainVC.alertControllerPlaceholder
            textField.delegate = self
        }
        
        let addAction = UIAlertAction(title: Strings.main.mainVC.addActionTitle, style: .default) { [weak self] _ in
            if let folderName = alertController.textFields?.first?.text, !folderName.isEmpty {
                guard
                    let self = self,
                    let user = self.viewModel.folderCollection.firebaseFolders.currentUserId else { return }
                        
                let newFolder = Folder(name: folderName, key: UUID().uuidString, authorID: user)
                
                self.viewModel.folderCollection.firebaseFolders.pushFolder(newFolder)
                
                self.collectionView.reloadData()
                
                self.changeContentOnScreen()
            }
        }
        
        let cancelAction = UIAlertAction(title: Strings.main.mainVC.cancelActionTitle, style: .cancel) { _ in
            self.view.endEditing(true)
        }
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        alertController.preferredAction = addAction
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func showUser() {
        if let _ = Auth.auth().currentUser {
            let vc = ProfileEditViewController(userFirebase: userViewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.pushViewController(AutharizationController(userVM: userViewModel), animated: true)
        }
    }
    
    @objc private func writeNote() {
        navigationItem.backBarButtonItem?.title = "К списку"
        if let userID = viewModel.noteCollection.firebaseNotes.currentUserId,
           let folderID = viewModel.getFolders().first?.key {
            
            let note = Note(folderID: folderID, key: UUID().uuidString, authorID: userID)
            let vc = NoteViewController(note: note)
            vc.sendable = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func switchCollectionLayout() {
        styleChangeSwitchButton()
        changeContentOnScreen()

        guard let layout = viewModel.collectionViewModel?.layout else { return }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    @objc private func segmentedChange() {
        let constants = Constants.Firebase.notesCollection.fields.self
        if segmentedControl.selectedSegmentIndex == 0 {
            viewModel.noteCollection.firebaseNotes.noteObserve(whereField: constants.authorID, isEqualTo: viewModel.noteCollection.firebaseNotes.currentUserId)
        } else {
            viewModel.noteCollection.firebaseNotes.noteObserve(whereField: constants.isPublic, isEqualTo: true)
        }
    }
    
    // MARK: - Constraints
    
    private func makeCollectionViewConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(switchMenuButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func makePersonButtonConstraints() {
        let personButtonConstants = Constants.MainVC.personButton.self
        
        personButton.snp.makeConstraints { make in
            make.width.height.equalTo(personButtonConstants.size)
            make.bottom.equalToSuperview().inset(personButtonConstants.bottomInset)
            make.trailing.equalToSuperview().inset(personButtonConstants.trailingInset)
        }
    }
    
    private func makeMenuButtonConstraints() {
        let menuButtonConstants = Constants.MainVC.menuButton.self
        
        menuButton.snp.makeConstraints { make in
            make.width.height.equalTo(menuButtonConstants.size)
            make.bottom.equalToSuperview().inset(menuButtonConstants.bottomInset)
            make.trailing.equalToSuperview().inset(menuButtonConstants.trailingInset)
        }
    }
    
    private func makeSegmentControllerConstraints() {
        let segmentedControlConstants = Constants.MainVC.segmentedControl.self
        
        segmentedControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(segmentedControlConstants.trailingInset)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(segmentedControlConstants.topOffset)
        }
    }
    
    private func makeNoContentViewConstraints() {
        let noContentViewConstants = Constants.MainVC.noContentView.self
        
        noContentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(noContentViewConstants.topOffset)
            make.leading.trailing.equalToSuperview().inset(noContentViewConstants.edgesInset)
        }
    }
    
    private func makeAddButtonConstraints() {
        let addButtonConstants = Constants.MainVC.addButton.self
        
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(addButtonConstants.size)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(addButtonConstants.bottomOffset)
        }
    }
    
    private func makeSwitchMenuButtonConstraints() {
        let switchMenuConstants = Constants.MainVC.switchMenuButton.self
        
        switchMenuButton.snp.makeConstraints { make in
            make.width.height.equalTo(switchMenuConstants.size)
            make.leading.equalTo(switchMenuConstants.leading)
            make.top.equalTo(segmentedControl.snp.bottom).offset(switchMenuConstants.top)
        }
    }
    
    private func makeNumberOfElementsConstraints() {
        let numberConstants = Constants.MainVC.numberOfElements.self
        
        numberOfElements.snp.makeConstraints { make in
            make.height.equalTo(numberConstants.size)
            make.trailing.equalTo(numberConstants.trailing)
            make.top.equalTo(segmentedControl.snp.bottom).offset(numberConstants.top)
        }
    }
}

extension MainViewController: NoteViewCellDelegate {
    func optionsIconTapped(cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        showActionSheetForNote(indexPath)
    }
}

extension MainViewController: Updatable {
    func update() {
        DispatchQueue.main.async {
            self.changeContentOnScreen()
            self.collectionView.reloadData()
        }
    }
}

extension MainViewController: NoteSendable {
    func createNote(note: Note) {
        viewModel.noteCollection.firebaseNotes.pushNote(note)
    }
    
    func updateNote(note: Note) {
        viewModel.noteCollection.firebaseNotes.updateNote(note)
    }
}

extension MainViewController: Unionable {
    func unionNotes() {
        viewModel.noteCollection.firebaseNotes.union()
        viewModel.folderCollection.firebaseFolders.union()
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if viewModel.isModeNotes {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteViewCell", for: indexPath) as! NoteViewCell
            
            let note = viewModel.getNotes()[indexPath.item]
            cell.delegate = self
            cell.configureCell(with: note)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderViewCell", for: indexPath) as! FolderViewCell
            let folder = viewModel.getFolders()[indexPath.item]
            cell.configureCell(with: folder)
            
            return cell
        }
        
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.isModeNotes {
            let note = viewModel.getNotes()[indexPath.item]
            navigationItem.backBarButtonItem?.title = "К списку"
            let vc = NoteViewController(note: note, isNewNote: false)
            vc.sendable = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let folder = viewModel.getFolders()[indexPath.item]
            showFolderNotesViewController(for: folder)
        }
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
        
        let title = viewModel.getNotes()[indexPath.item].isPublic ? "Сделать приватной" : "Сделать публичной"
        let actionPrivacyNote = UIAlertAction(title: title, style: .default) { _ in
            let note = self.viewModel.getNotes()[indexPath.item]
            note.isPublic.toggle()
            self.viewModel.noteCollection.firebaseNotes.updateNote(note)
        }
        
        let actionCancel = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
        
        actionSheet.addAction(actionDeleteNote)
        actionSheet.addAction(actionSelectFolder)
        actionSheet.addAction(actionCancel)
        
        if let _ = Auth.auth().currentUser {
            actionSheet.addAction(actionPrivacyNote)
        }
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        
        guard
            let userID = userViewModel.currentUserId,
            self.viewModel.getNotes()[indexPath.item].authorID == userID
        else { return }
        
        present(actionSheet, animated: true, completion: nil)
    }
}
