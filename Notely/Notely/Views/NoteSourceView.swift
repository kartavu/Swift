//
//  NoteFromView.swift
//  Notely
//
//  Created by Данил Соколов on 20.09.2023.
//

import UIKit
import SnapKit

class NoteSourceView: UIView {
    
    private let firebase = NoteViewModel()

    private let imageView = UIImageView()
    private let label = UILabel()
    private let stackView = UIStackView()
    private let circleView = UIView()
    private let userIconView = UIView()
    private let initialsLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupUI()
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        makeStackConstraints()
        makeImageConstraints()
    }
    
    init(note: Note?) {
        super.init(frame: .zero)
        setupUI()
        
        setNote(note)
        
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        makeStackConstraints()
        makeImageConstraints()
    }
    
    func setNote(_ note: Note?) {
        if let note = note {
            if note.authorID == firebase.currentUserId {
                configureFolderView(note)
            } else {
                configureUserView(note)
            }
        }
    }
    
    func clearView() {
        imageView.image = nil
        label.text = ""
        initialsLabel.text = ""
        circleView.removeFromSuperview()
    }

    private func setupUI() {
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        stackView.axis = .horizontal
        stackView.spacing = 5
        circleView.backgroundColor = .gray
        circleView.layer.cornerRadius = 9
        circleView.clipsToBounds = true
        initialsLabel.textColor = .white
        initialsLabel.font = UIFont.boldSystemFont(ofSize: 10)
        initialsLabel.textAlignment = .center
    }
    
    private func configureFolderView(_ note: Note) {
        firebase.getFolderName(by: note.folderID) { [weak self] name in
            guard let self = self else { return }
            label.text = name
        }
        imageView.image = UIImage(systemName: "folder")
        imageView.tintColor = .lightGray
    }
    
    private func configureUserView(_ note: Note) {
        firebase.getUser(by: note.authorID) { [weak self] user in
            guard let self = self else { return }
            
            label.text = "\(user.name) \(user.surname)"
            initialsLabel.text = "\(user.name.prefix(1))\(user.surname.prefix(1))"
            
            userIconView.addSubview(circleView)
            
            circleView.snp.makeConstraints { make in
                make.top.leading.trailing.bottom.equalToSuperview()
            }

            userIconView.addSubview(initialsLabel)
            
            initialsLabel.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }

            addSubview(userIconView)
            
            userIconView.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(0)
                make.width.height.equalTo(18)
            }
            
        }
    }

    private func makeStackConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }

    private func makeImageConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
