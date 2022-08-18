//
//  NewFuncTableViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/18.
//

import UIKit

class NewFuncTableViewCell: UITableViewCell {
    
    private var versionLabel = UILabel()
    private var scriptLabel = UILabel()
    
    func setup(_ viewModel: DetailViewModel) {
        versionLabel.text = viewModel.getVersion()
        versionLabel.textColor = .systemGray
        
        scriptLabel.text = viewModel.getScript()
        scriptLabel.numberOfLines = 0
        
        layout()
    }
}

extension NewFuncTableViewCell {
    
    private func layout() {
        [
            versionLabel,
            scriptLabel
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 14
        
        NSLayoutConstraint.activate([
            versionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            versionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            versionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            versionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            scriptLabel.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 8),
            scriptLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            scriptLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            scriptLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset)
        ])
    }
}
