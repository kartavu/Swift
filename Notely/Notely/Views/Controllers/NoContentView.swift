//
//  NoContentView.swift
//  Notely
//
//  Created by Masha on 16.09.2023.
//

import Foundation
import UIKit

class NoContentView: UIView {
    
    private let noteView: UIImageView = {
        let noteView = UIImageView()
        noteView.image = UIImage(named: Constants.NoContentVC.noteView.imageName)
        return noteView
    }()
    
    private let titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.numberOfLines = Constants.NoContentVC.titleLable.numberOfLines
        titleLable.textColor = .black
        titleLable.font = UIFont.boldSystemFont(ofSize: Constants.NoContentVC.titleLable.textOfSize)
        titleLable.text = Strings.main.NoContentView.titleLableText
        return titleLable
    }()
    
    private let descriptionLable: UILabel = {
        let descriptionLable = UILabel()
        descriptionLable.numberOfLines = Constants.NoContentVC.descriptionLable.numberOfLines
        descriptionLable.textColor = .gray
        descriptionLable.font = UIFont.systemFont(ofSize: Constants.NoContentVC.descriptionLable.textOfSize)
        descriptionLable.text = Strings.main.NoContentView.descriptionLableText
        descriptionLable.textAlignment = .center
        return descriptionLable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeNoteViewConstraints()
        makeTitleLableConstraints()
        makeDescriptionLableConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        makeNoteViewConstraints()
        makeTitleLableConstraints()
        makeDescriptionLableConstraints()
    }
    
    private func addSubviews() {
        addSubview(noteView)
        addSubview(titleLable)
        addSubview(descriptionLable)
    }
    
    private func makeNoteViewConstraints() {
        let noteViewConstants = Constants.NoContentVC.noteView.self
        
        noteView.snp.makeConstraints { make in
            make.width.height.equalTo(noteViewConstants.size)
            make.centerX.equalToSuperview()
            make.top.equalTo(noteViewConstants.top)
        }
    }
    
    private func makeTitleLableConstraints() {
        let titleLableConstants = Constants.NoContentVC.titleLable.self
        
        titleLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noteView.snp.bottom).offset(titleLableConstants.topOffset)
        }
    }
    
    private func makeDescriptionLableConstraints() {
        let descriptionLableConstants = Constants.NoContentVC.descriptionLable.self
        
        descriptionLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLable.snp.bottom).offset(descriptionLableConstants.topOffset)
            make.trailing.equalToSuperview().inset(descriptionLableConstants.trailingInset)
            make.bottom.equalToSuperview().inset(descriptionLableConstants.bottomInset)
        }
    }
}
