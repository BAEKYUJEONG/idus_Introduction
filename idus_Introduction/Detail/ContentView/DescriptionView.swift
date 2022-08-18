//
//  DescriptionView.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/17.
//

import UIKit

class DescriptionView: UIView {
    
    private var viewModel = DetailViewModel()
    private var descriptionTextView = UITextView()
    private var foldableButton: UIButton = {
        var button = UIButton()
        button.tintColor = .systemPink
        return button
    }()
    
    init(_ viewModel: DetailViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel

        layout()
        setupTextView()
        setupButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout() {
        [
            descriptionTextView,
            foldableButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            
            foldableButton.widthAnchor.constraint(equalToConstant: 100),
            foldableButton.heightAnchor.constraint(equalToConstant: 100),
            foldableButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            foldableButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupTextView() {
        descriptionTextView.text = viewModel.getDescription()
        
//        descriptionTextView.textContainer.maximumNumberOfLines = 3
//        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    func setupButton() {
        foldableButton.addTarget(self, action: #selector(touchFoldableButton(_:)), for: .touchUpInside)
    }
    
    @objc func touchFoldableButton(_ sender: UIButton) {
        if sender.isSelected {
            descriptionTextView.textContainer.maximumNumberOfLines = 0
            descriptionTextView.invalidateIntrinsicContentSize()
        } else {
            descriptionTextView.textContainer.maximumNumberOfLines = 3
            descriptionTextView.invalidateIntrinsicContentSize()
        }
    }
}
