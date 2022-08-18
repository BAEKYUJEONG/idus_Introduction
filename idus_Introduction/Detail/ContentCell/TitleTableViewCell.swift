//
//  TitleTableViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/18.
//

import UIKit

class TitleTableViewCell: UITableViewCell, ReusableCell {
    
    private var appIconImage = UIImageView()
    private var appTitle = UILabel()
    
    func setup(_ viewModel: DetailViewModel) {
        viewModel.getAppIconImage { image in
            DispatchQueue.main.async {
                self.appIconImage.image = image
            }
        }
        
        layout()
        setupIconImage()
    }
}

extension TitleTableViewCell {
    
    private func layout() {
        [
            appIconImage,
            appTitle
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            appIconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            appIconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            appIconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
            appIconImage.heightAnchor.constraint(equalTo: appIconImage.widthAnchor),
            
            appTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            appTitle.leadingAnchor.constraint(equalTo: appIconImage.leadingAnchor, constant: inset),
            appTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            appTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupIconImage() {
        appIconImage.clipsToBounds = true
        appIconImage.layer.cornerRadius = 24
    }
}
