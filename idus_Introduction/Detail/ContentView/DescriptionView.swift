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
    
    init(_ viewModel: DetailViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel

        layout()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layout() {
        [
            descriptionTextView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            descriptionTextView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 20),
            descriptionTextView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 20)
        ])
    }
    
    func setup() {
        descriptionTextView.text = viewModel.getDescription()
    }
}
