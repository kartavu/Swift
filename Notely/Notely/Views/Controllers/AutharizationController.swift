//
//  AutharizationController.swift
//  Notely
//
//  Created by Tima Shchekochikhin on 14.09.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

class AutharizationController: UIViewController {
    
    // MARK: - Private properties
    
    private let authSegmentedControl = UISegmentedControl()
    private let authInfoLabel = UILabel()
    private let authTableView = UITableView()
    private let authEnterButton = UIButton()
    
    init(userVM: UserFirebase) {
        logViewModel = LoginViewModel(userFirebase: userVM)
        regViewModel = RegistrationViewModel(userFirebase: userVM)
        validViewModel = ValidationViewModel()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private var logViewModel: LoginViewModel
    private var regViewModel: RegistrationViewModel
    private var authViewModel: AutharizationViewModel?
    private var validViewModel: ValidationViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authViewModel = logViewModel
        navigationItem.backBarButtonItem?.title = Strings.auth.navigationTitle
        
        addKeyboardObserver()
        dismisKeyboard()
        
        configureTable()
        configureView()
        configureSegmentControl()
        configureInfoLabel()
        configureEnterButton()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Private methods
    
    private func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    private func registerCells() {
        authTableView.register(TextEditCell.self, forCellReuseIdentifier: TextEditCell.cellIdentifier)
        authTableView.register(TextViewEditCell.self, forCellReuseIdentifier: TextViewEditCell.cellIdentifier)
    }
    
    private func checkValidData() -> Bool {
        var errorStatus = true
        if authSegmentedControl.selectedSegmentIndex == 1 {
            let loginValidStatus = validViewModel.checkValidLogin(regViewModel.registration.login)
            let passwordValidStatus = validViewModel.checkValidPassword(regViewModel.registration.password)
            
            if let loginCell = regViewModel.cellViewModels?[0] as? TextEditViewModel {
                if loginValidStatus != Constants.ValidationVC.correctValidStatus {
                    loginCell.error = loginValidStatus
                    errorStatus = false
                } else {
                    loginCell.error = ""
                }
            }
            
            if let passwordCell = regViewModel.cellViewModels?[1] as? TextEditViewModel {
                if passwordValidStatus != Constants.ValidationVC.correctValidStatus {
                    passwordCell.error = passwordValidStatus
                    errorStatus = false
                } else {
                    passwordCell.error = ""
                }
            }
        } else {
            let loginValidStatus = validViewModel.checkValidLogin(logViewModel.autharization.login)
            let passwordValidStatus = validViewModel.checkValidPassword(logViewModel.autharization.password)
            
            if let loginCell = logViewModel.cellViewModels?[0] as? TextEditViewModel {
                if loginValidStatus != Constants.ValidationVC.correctValidStatus {
                    loginCell.error = loginValidStatus
                    errorStatus = false
                } else {
                    loginCell.error = ""
                }
            }
            
            if let passwordCell = logViewModel.cellViewModels?[1] as? TextEditViewModel {
                if passwordValidStatus != Constants.ValidationVC.correctValidStatus {
                    passwordCell.error = passwordValidStatus
                    errorStatus = false
                } else {
                    passwordCell.error = ""
                }
            }
        }
        
        authTableView.reloadData()
        return errorStatus
    }
    
    @objc private func authTapped() {
        authViewModel?.authorization(vc: self)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(authSegmentedControl)
        view.addSubview(authInfoLabel)
        view.addSubview(authTableView)
        view.addSubview(authEnterButton)
    }
    
    private func configureSegmentControl() {
        authSegmentedControl.insertSegment(withTitle: Strings.auth.segmentedControlItems.firstItem, at: 0, animated: false)
        authSegmentedControl.insertSegment(withTitle: Strings.auth.segmentedControlItems.secondItem, at: 1, animated: false)
        authSegmentedControl.addTarget(self, action: #selector(selectorControlChangeStatus), for: .valueChanged)
        authSegmentedControl.selectedSegmentIndex = 0
    }
    
    private func configureInfoLabel() {
        authInfoLabel.numberOfLines = 0
        authInfoLabel.font = Constants.AutharizationVC.infoLabel.textFont
        authInfoLabel.textColor = Constants.AutharizationVC.infoLabel.textColor
        authInfoLabel.text = Strings.auth.authInfoText
    }
    
    private func configureTable() {
        authTableView.separatorStyle = .none
        authTableView.translatesAutoresizingMaskIntoConstraints = false
        authTableView.allowsSelection = false
        authTableView.delegate = self
        authTableView.dataSource = self
        registerCells()
    }
    
    private func configureEnterButton() {
        authEnterButton.setTitle(Strings.auth.enterButton.logText, for: .normal)
        authEnterButton.titleLabel?.font = Constants.AutharizationVC.authEnterButton.fontText
        authEnterButton.setTitleColor(.white, for: .normal)
        authEnterButton.layer.backgroundColor = Constants.AutharizationVC.authEnterButton.backgroundColor
        authEnterButton.layer.cornerRadius = Constants.AutharizationVC.authEnterButton.cornerRadius
        authEnterButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    private func updateConstrains() {
        authEnterButton.snp.updateConstraints { make in
            if authSegmentedControl.selectedSegmentIndex == 0 {
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.AutharizationVC.authEnterButton.botYOffset)
            } else {
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.AutharizationVC.authEnterButton.botYOffsetSmall)
            }
            
        }
        view.updateConstraints()
    }
    
    // MARK: - Constrains
    
    private func setupConstrains() {
        authSegmentedControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.AutharizationVC.centerXOffset)
            make.height.equalTo(Constants.AutharizationVC.authSegmentedControl.height)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.AutharizationVC.authSegmentedControl.topYOffset)
        }
        authInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(authSegmentedControl.snp.bottom).offset(Constants.AutharizationVC.infoLabel.topYOffset)
            make.left.right.equalToSuperview().inset(Constants.AutharizationVC.centerXOffset)
        }
        authEnterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.AutharizationVC.authEnterButton.botYOffset)
            make.left.right.equalToSuperview().inset(Constants.AutharizationVC.centerXOffset)
            make.height.equalTo(Constants.AutharizationVC.authEnterButton.height)
            make.top.equalTo(authTableView.snp.bottom).offset(Constants.AutharizationVC.authEnterButton.topYOffset)
        }
        authTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(authInfoLabel.snp.bottom).offset(Constants.AutharizationVC.tableView.topYOffset)
        }
    }
    
    // MARK: - Objc methods
    
    @objc private func selectorControlChangeStatus() {
        if authSegmentedControl.selectedSegmentIndex == 0 {
            authViewModel = logViewModel
            authInfoLabel.text = Strings.auth.authInfoText
            authEnterButton.setTitle(Strings.auth.enterButton.logText, for: .normal)
        } else {
            authViewModel = regViewModel
            authInfoLabel.text = Strings.auth.regInfoText
            authEnterButton.setTitle(Strings.auth.enterButton.regText, for: .normal)
        }
        
        let loginCell = authViewModel?.cellViewModels?[0] as? TextEditViewModel
        let passwordCell = authViewModel?.cellViewModels?[1] as? TextEditViewModel
        loginCell?.error = ""
        passwordCell?.error = ""
        
        updateConstrains()
        authTableView.reloadData()
    }
    
    @objc private func buttonClicked() {
        let validStatus = checkValidData()
        if validStatus {
            authViewModel?.authorization(vc: self)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            authTableView.contentInset = contentInset
            authTableView.scrollIndicatorInsets = contentInset
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        authTableView.contentInset = contentInset
    }
    
    @objc private func dismisKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

extension AutharizationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = authViewModel?.cellViewModels?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellViewModel = authViewModel?.cellViewModels?[indexPath.row] as? TextEditViewModel {
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

extension AutharizationController: UpdateCellHeightDelegate {
    func updateHeight() {
        UIView.performWithoutAnimation {
            authTableView.beginUpdates()
            authTableView.endUpdates()
            guard let count = authViewModel?.cellViewModels?.count else { return }
            authTableView.scrollToRow(at: IndexPath(row: count - 1, section: 0), at: .bottom, animated: true)
        }
    }
}

extension String {
    func withoutEmoji() -> String {
        filter { $0.isASCII }
    }
}
