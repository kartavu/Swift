//
//  TextViewEditCell.swift
//  Notely
//
//  Created by Данил Соколов on 15.09.2023.
//

import UIKit
import SnapKit

protocol UpdateCellHeightDelegate: AnyObject {
    func updateHeight()
}

class TextViewEditCell: UITableViewCell, ReusableCell {
    
    private let titleLabel: UILabel = {
        let labelConstants = Constants.ProfileEditVC.tableView.cell.label.self
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: labelConstants.fontSize)
        label.textColor = labelConstants.color
        return label
    }()
    private let infoTextView = NotelyTextView()
    private var heightConstraint: Constraint!
    
    var viewModel: TextEditViewModel? {
        didSet {
            update()
        }
    }
    
    weak var updateHeightDelegate: UpdateCellHeightDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeTitleConstraints()
        makeTextFieldConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        updateHeightDelegate = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoTextView)
    }
    
    private func makeTitleConstraints() {
        let cellConstants = Constants.ProfileEditVC.tableView.cell.self

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(cellConstants.leadingTrailingOffset)
            make.top.equalToSuperview().offset(cellConstants.label.topOffset)
        }
    }
    
    private func makeTextFieldConstraints() {
        infoTextView.snp.makeConstraints { make in
            let cellConstants = Constants.ProfileEditVC.tableView.cell.self
            
            make.leading.equalToSuperview().offset(cellConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().inset(cellConstants.leadingTrailingOffset)
            make.top.equalTo(titleLabel.snp.bottom).offset(cellConstants.textField.topOffset)
            make.bottom.equalToSuperview().inset(cellConstants.textField.bottomOffset)
            heightConstraint = make.height.greaterThanOrEqualTo(calculateHeight(in: infoTextView)).constraint
        }
    }
    
    private func calculateHeight(in textView: UITextView) -> CGSize {
        let size = CGSize(width: textView.frame.size.width, height: .infinity)
        return textView.sizeThatFits(size)
    }
    
    private func update() {
        infoTextView.addPlaceholder(viewModel?.placeholder ?? "")
        infoTextView.delegate = self
        
        infoTextView.text = viewModel?.value
        textViewDidChange(infoTextView)
        
        titleLabel.text = viewModel?.title
    }
}

extension TextViewEditCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.changeValue(text: textView.text ?? "")
        
        updatePlaceholder(textView)
        
        let estimatedSize = calculateHeight(in: textView)
        guard textView.contentSize.height < Constants.NotelyTextView.limitHeight
        else { textView.isScrollEnabled = true; return }

        textView.isScrollEnabled = false
        
        heightConstraint.deactivate()
        textView.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(estimatedSize).constraint
        }
        updateHeightDelegate?.updateHeight()
    }
    
    private func updatePlaceholder(_ textView: UITextView) {
        let constant = Constants.NoteVC.textView.placeholder.self

        if let placeholderLabel = self.viewWithTag(constant.tag) as? UILabel {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
}
