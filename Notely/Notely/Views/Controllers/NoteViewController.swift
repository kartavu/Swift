//
//  NoteViewController.swift
//  Notely
//
//  Created by Миша Кацуро on 19.09.2023.
//
import UIKit
import SnapKit
import FirebaseAuth

protocol NoteSendable: AnyObject {
    func createNote(note: Note)
    func updateNote(note: Note)
}

class NoteViewController: UIViewController {
    
    weak var sendable: NoteSendable?
    
    private var note: Note?
    private var isNewNote: Bool = true
    
    private var firebase = NoteViewModel()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = Constants.NoteVC.titleTextField.font
        textField.textColor = .black
        textField.placeholder = Strings.main.NoteVC.titleTextFieldPlaceholder
        textField.backgroundColor = .white
        textField.borderStyle = .none
        return textField
    }()
    
    private var sourceView: NoteSourceView
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.NoteVC.dateLabel.font
        label.textColor = .lightGray
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.font = Constants.NoteVC.textView.font
        textView.isScrollEnabled = true
        textView.addPlaceholder(Strings.main.NoteVC.textViewPlaceholder)
        return textView
    }()
    

    
    init(note: Note? = nil, isNewNote: Bool = true) {
        // TODO: Make ViewModel for Note and fill properties
        
        self.note = note
        self.isNewNote = isNewNote
        
        titleTextField.text = note?.title
        textView.text = note?.text
        
        sourceView = NoteSourceView(note: note)
        
        super.init(nibName: nil, bundle: nil)
        
        if firebase.currentUserId != note?.authorID {
            titleTextField.isUserInteractionEnabled = false
            textView.isUserInteractionEnabled = false
            let tap = UITapGestureRecognizer(target: self, action: #selector(showProfile))
            sourceView.addGestureRecognizer(tap)
        }
        
        textView.delegate = self
        textViewDidChange(textView)
        dateLabel.text = note?.dateToString() ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showProfile() {
        guard let note = note else { return }
        firebase.getUser(by: note.authorID) { [weak self] info in
            guard let self = self else { return }
            let vc = PublicProfileViewController(profileInfo: info)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        createOptionButton()
        
        makeConstraints()
        
        swipeDownKeyboard()
        addNotificationCenter()
    }
    
    private func swipeDownKeyboard() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    
    private func addNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        textView.contentInset = contentInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        textView.contentInset = .zero
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let title = titleTextField.text, !title.isEmpty,
           let text = textView.text, !text.isEmpty,
           let note = note {
            note.title = title
            note.text = text
            if isNewNote {
                sendable?.createNote(note: note)
            } else {
                sendable?.updateNote(note: note)
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(titleTextField)
        stackView.addArrangedSubview(sourceView)
        stackView.addArrangedSubview(dateLabel)
        view.addSubview(stackView)
        view.addSubview(textView)
    }
    
    private func createOptionButton() {
        let optionButton = UIBarButtonItem(image: UIImage(systemName: Constants.NoteVC.optionButtonName), style: .plain, target: self, action: #selector(openMenu))
        optionButton.tintColor = .black
        navigationItem.rightBarButtonItem = optionButton
    }
    
    // MARK: - Constraints
    
    private func makeConstraints() {
        makeTextFieldConstraints()
        makeStackViewConstraints()
        makeTextViewConstraints()
    }
    
    private func makeTextFieldConstraints() {
        titleTextField.snp.makeConstraints { (make) in
            let constant = Constants.NoteVC.titleTextField.self
            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(constant.topOffset)
            make.leading.equalTo(view.snp.leading).offset(constant.leadingOffset)
            make.trailing.equalTo(view.snp.trailing).inset(constant.trailingOffset)
            make.height.equalTo(constant.height)
        }
    }
    
    private func makeStackViewConstraints() {
        stackView.snp.makeConstraints { make in
            let constant = Constants.NoteVC.stackView.self
            
            make.top.equalTo(titleTextField.snp.bottom).offset(constant.topOffset)
            make.leading.equalToSuperview().offset(constant.leadingOffset)
            make.trailing.equalToSuperview().inset(constant.trailingOffset)
            make.height.equalTo(constant.height)
        }
    }
    
    private func makeTextViewConstraints() {
        textView.snp.makeConstraints { (make) in
            let constant = Constants.NoteVC.textView.self
            
            make.top.equalTo(stackView.snp.bottom).offset(constant.topOffset)
            make.leading.equalToSuperview().offset(constant.leadingOffset)
            make.trailing.equalToSuperview().inset(constant.trailingOffset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(constant.bottomOffser)
        }
    }
    
    @objc private func openMenu() {
        let alertController = NoteAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if firebase.currentUserId == note?.authorID {
            alertController.deleteClosure = { [weak self] in
                guard let self = self else { return }
                self.note?.ref?.delete()
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        alertController.shareClosure = { [weak self] in
            guard
                let self = self,
                let noteTitle = titleTextField.text,
                let noteText = textView.text
            else { return }
            let shareText = "\(noteTitle)\n\(noteText)"
            let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension NoteViewController: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        let constant = Constants.NoteVC.textView.placeholder.self
        
        if let placeholderLabel = textView.viewWithTag(constant.tag) as? UILabel {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
    
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}

extension UITextView {
    func addPlaceholder(_ placeholder: String) {
        let constant = Constants.NoteVC.textView.placeholder.self
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = self.font
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = constant.tag
        
        placeholderLabel.isHidden = !self.text.isEmpty
        self.addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(constant.topOffset)
            make.leading.equalToSuperview().offset(constant.leadingOffset)
        }
    }
}
