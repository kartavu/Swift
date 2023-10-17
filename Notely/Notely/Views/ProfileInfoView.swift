//
//  ProfileInfoView.swift
//  Notely
//
//  Created by quest_01 on 20/09/2023.
//

import UIKit

class ProfileInfoView: UIView {
    
    // MARK: - Private properties
    
    
    private let profileInfo: ProfileInfo
    
    private let horizontalStackView = UIStackView()
    private let profileIconView = UIView()
    private let iconProfile = UILabel()
    private let nameStackView = UIStackView()
    private let nameLabel = UILabel()
    private let numberNotes = UILabel()
    private let infoAboutMeLabel = UILabel()
    
    init(profileInfo: ProfileInfo) {
        self.profileInfo = profileInfo
        super.init(frame: .zero)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    
    private func configure() {
        configureContainerView()
        configureHorizontalStackView()
        configureProfileIconView()
        configureNameStackView()
        configureNameLabel()
        configureNumberOfNotesLabel()
        configureInfoAboutMeLabel()
    }
    
    private func configureContainerView() {
        backgroundColor = Constants.PublicProfile.containerView.color
    }

    private func configureHorizontalStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        addSubview(horizontalStackView)
    }
        
    private func configureProfileIconView() {
        var iconInitials: String = ""
        if let firstCharOfName = profileInfo.name.first {
            iconInitials += String(firstCharOfName)
        }
        
        if let firstCharOfSurname = profileInfo.surname.first {
            iconInitials += String(firstCharOfSurname)
        }
        
        iconProfile.text = iconInitials
        iconProfile.textColor = Constants.PublicProfile.profileIcon.iconProfile.color
        iconProfile.textAlignment = .center
        iconProfile.font = Constants.PublicProfile.profileIcon.iconProfile.font
        
        profileIconView.backgroundColor = Constants.PublicProfile.profileIcon.profileIconView.color
        profileIconView.addSubview(iconProfile)
        profileIconView.layer.cornerRadius = Constants.PublicProfile.profileIcon.profileIconView.cornerRadius

        horizontalStackView.addArrangedSubview(profileIconView)

        horizontalStackView.setCustomSpacing(12, after: profileIconView)
    }
        
    private func configureNameStackView() {
        nameStackView.axis = .vertical
        nameStackView.spacing = Constants.PublicProfile.nameStackView.spacing
        nameStackView.alignment = .leading
        horizontalStackView.addArrangedSubview(nameStackView)
    }
        
    private func configureNameLabel() {
        nameLabel.text = profileInfo.surname + " " + profileInfo.name
        nameLabel.textAlignment = .left
        nameStackView.addArrangedSubview(nameLabel)
    }
        
    private func configureNumberOfNotesLabel() {
//        numberNotes.text = "\(profileInfo.notes.count) заметок"
        numberNotes.textAlignment = .left
        numberNotes.font = Constants.PublicProfile.numberOfNotesLabel.font
        numberNotes.textColor = Constants.PublicProfile.numberOfNotesLabel.color
        nameStackView.addArrangedSubview(numberNotes)
    }
        
    private func configureInfoAboutMeLabel() {
        infoAboutMeLabel.text = profileInfo.about
        infoAboutMeLabel.textAlignment = .left
        infoAboutMeLabel.numberOfLines = Constants.PublicProfile.infoAboutMeLabel.numberOfLines
        addSubview(infoAboutMeLabel)
    }
        
    // MARK: - Constraints
        
    private func makeConstraints() {
        makeHorizontalStackViewConstraints()
        makeProfileIconViewConstraints()
        makeInfoAboutMeLabelConstraints()
    }
    
    private func makeHorizontalStackViewConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func makeProfileIconViewConstraints() {
        let profileIconViewConstants = Constants.PublicProfile.profileIcon.profileIconView.self
        
        profileIconView.snp.makeConstraints { make in
            make.width.height.equalTo(profileIconViewConstants.size)
        }
        
        iconProfile.snp.makeConstraints { make in
            make.center.equalTo(profileIconView)
        }
    }
    
    private func makeInfoAboutMeLabelConstraints() {
        let infoAboutMeLabelConstants = Constants.PublicProfile.infoAboutMeLabel.self
        
        infoAboutMeLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(infoAboutMeLabelConstants.topOffset)
            make.left.equalToSuperview().offset(infoAboutMeLabelConstants.leftOffset)
            make.right.equalToSuperview().offset(infoAboutMeLabelConstants.rightOffset)
            make.bottom.equalToSuperview().offset(infoAboutMeLabelConstants.bottomOffset)
        }
    }
}
