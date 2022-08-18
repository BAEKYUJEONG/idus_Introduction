//
//  TitleTableViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/18.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    private var appIconImage = UIImageView()
    private var appTitle = UILabel()
    private var artistName = UILabel()
    
    func setup(_ viewModel: DetailViewModel) {
        layout()
        setupIconImage(viewModel)
        setupTitle(viewModel)
        setupArtistName(viewModel)
    }
}

extension TitleTableViewCell {
    
    private func layout() {
        [
            appIconImage,
            appTitle,
            artistName
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 14
        
        NSLayoutConstraint.activate([
            appIconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            appIconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            appIconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
            appIconImage.heightAnchor.constraint(equalTo: appIconImage.widthAnchor),
            
            appTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            appTitle.leadingAnchor.constraint(equalTo: appIconImage.trailingAnchor, constant: inset),
            appTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            appTitle.heightAnchor.constraint(equalToConstant: 20),
            
            artistName.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 8),
            artistName.leadingAnchor.constraint(equalTo: appIconImage.trailingAnchor, constant: inset),
            artistName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            artistName.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func setupIconImage(_ viewModel: DetailViewModel) {
        appIconImage.clipsToBounds = true
        appIconImage.layer.cornerRadius = 10
        
        viewModel.getAppIconImage { image in
            DispatchQueue.main.async {
                self.appIconImage.image = image
            }
        }
    }
    
    private func setupTitle(_ viewModel: DetailViewModel) {
        appTitle.text = viewModel.getTitle()
        appTitle.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func setupArtistName(_ viewModel: DetailViewModel) {
        artistName.text = viewModel.getArtistName()
        artistName.textColor = .systemGray
        artistName.font = UIFont.systemFont(ofSize: 16)
    }
}
