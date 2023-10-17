//
//  TemplateViewController.swift
//  Notely
//
//  Created by Данил Соколов on 12.09.2023.
//

import UIKit
import SnapKit
import Firebase

class ProfileEditViewController: UIViewController {
    
    // MARK: - Private properties
    
    var userFirebase: UserFirebase
    private var viewModel: ProfileInfoViewModel?
    private var profileInfo: ProfileInfo?
    
    private let infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let profileSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.main.profileEditVC.saveButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.ProfileEditVC.profileSaveButton.cornerRadius
        button.layer.backgroundColor = Constants.ProfileEditVC.profileSaveButton.color
        button.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        return button
    }()
    private let profileIcon: UIImageView = {
        let image = UIImage(systemName: Constants.ProfileEditVC.profileIcon.imageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)

        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    init(userFirebase: UserFirebase) {
        self.userFirebase = userFirebase
        profileInfo = userFirebase.user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProfileInfoViewModel(profileInfo: profileInfo)
        
        addKeyboardObserver()
        dismisKeyboard()
        setupTableView()
        
        configureView()
        configureNavigator()
        addSubviews()
        makeTableViewConstraints()
        makeSaveButtonConstraints()
        makeProfileIconConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        profileIcon.isHidden = true
    }
    
    // MARK: - Public methods
    
    func setProfileInfo(_ profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        view.backgroundColor = .white
    }
    
    private func configureNavigator() {
        navigationItem.title = Strings.main.profileEditVC.title
        navigationController?.navigationBar.addSubview(profileIcon)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews() {
        view.addSubview(infoTableView)
        view.addSubview(profileSaveButton)
    }
    
    private func setupTableView() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        infoTableView.register(TextEditCell.self, forCellReuseIdentifier: TextEditCell.cellIdentifier)
        infoTableView.register(TextViewEditCell.self, forCellReuseIdentifier: TextViewEditCell.cellIdentifier)
    }
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    @objc private func saveProfile() {
        userFirebase.updateProfileInfo(with: profileInfo)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            infoTableView.contentInset = contentInset
            infoTableView.scrollIndicatorInsets = contentInset
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        infoTableView.contentInset = contentInset
    }
    
    @objc func dismisKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
        
    // MARK: - Constraints
    
    private func makeTableViewConstraints() {
        infoTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.ProfileEditVC.tableView.topOffset)
        }
    }
    
    private func makeSaveButtonConstraints() {
        profileSaveButton.snp.makeConstraints { make in
            let buttonConstants = Constants.ProfileEditVC.profileSaveButton.self
            
            make.leading.equalToSuperview().offset(buttonConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().inset(buttonConstants.leadingTrailingOffset)
            make.bottom.equalToSuperview().inset(buttonConstants.bottomOffset)
            make.height.equalTo(buttonConstants.height)
        }
    }
    
    private func makeProfileIconConstraints() {
        profileIcon.snp.makeConstraints { make in
            let iconConstants = Constants.ProfileEditVC.profileIcon.self
            
            make.width.height.equalTo(iconConstants.size)
            make.bottom.equalToSuperview().inset(iconConstants.bottomOffset)
            make.trailing.equalToSuperview().inset(iconConstants.trailingOffset)
        }
    }
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellViewModel = viewModel?.cellViewModels[indexPath.row] as? TextEditViewModel {
            let cell = cellViewModel.getCell(from: tableView, for: indexPath)
            if let cell = cell as? TextViewEditCell {
                cell.updateHeightDelegate = self
            }
            return cell 
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ProfileEditViewController: UpdateCellHeightDelegate {
    func updateHeight() {
        UIView.performWithoutAnimation {
            infoTableView.beginUpdates()
            infoTableView.endUpdates()
            guard let count = viewModel?.cellViewModels.count else { return }
            infoTableView.scrollToRow(at: IndexPath(row: count - 1, section: 0), at: .bottom, animated: true)

        }
    }
}
