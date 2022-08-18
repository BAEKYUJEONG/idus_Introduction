//
//  DescriptionTableViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/17.
//

import UIKit

protocol FoldableDelegate: AnyObject {
    func setTextViewHeight(height: CGFloat)
}

protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}

class DescriptionTableViewCell: UITableViewCell {
    
    weak var delegate: FoldableDelegate?
    private var descriptionTextView = UITextView()
    private var foldableButton: UIButton = {
        var button = UIButton()
        button.setTitle("펼치기", for: .normal)
        button.setTitle("접기", for: .selected)
        button.backgroundColor = .black
        return button
    }()
    
    func setup(_ viewModel: DetailViewModel) {
        descriptionTextView.text = viewModel.getDescription()
        descriptionTextView.font = UIFont.systemFont(ofSize: 16)
        
        descriptionTextView.textContainer.maximumNumberOfLines = 0
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        
        layout()
        setupButton()
    }
}

extension DescriptionTableViewCell {
    
    private func layout() {
        [
            descriptionTextView,
            foldableButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
            
            foldableButton.widthAnchor.constraint(equalToConstant: 50),
            foldableButton.heightAnchor.constraint(equalToConstant: 20),
            foldableButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            foldableButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset)
        ])
    }
    
    private func setupButton() {
        setupLine()
        foldableButton.addTarget(self, action: #selector(touchFoldableButton), for: .touchUpInside)
    }
    
    private func setupLine() {
        let contentSize = descriptionTextView.contentSize.height - descriptionTextView.textContainerInset.top - descriptionTextView.textContainerInset.bottom
        delegate?.setTextViewHeight(height: contentSize)
    }
    
    @objc private func touchFoldableButton() {
        foldableButton.isSelected = !foldableButton.isSelected
        
        if foldableButton.isSelected {
            descriptionTextView.textContainer.maximumNumberOfLines = 0
            descriptionTextView.invalidateIntrinsicContentSize()
        } else {
            descriptionTextView.textContainer.maximumNumberOfLines = 5
            descriptionTextView.invalidateIntrinsicContentSize()
        }
    }
}
