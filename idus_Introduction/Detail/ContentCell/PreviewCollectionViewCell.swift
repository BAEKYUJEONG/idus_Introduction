//
//  PreviewCollectionViewCell.swift
//  idus_Introduction
//
//  Created by 백유정 on 2022/08/16.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}

class PreviewCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    private let previewImage = UIImageView()
    
    func setup(_ indexPath: IndexPath, _ viewModel: DetailViewModel) {
        layout()
        loadImage(indexPath, viewModel)
    }
    
    private func loadImage(_ indexPath: IndexPath, _ viewModel: DetailViewModel) {
        viewModel.fetchScreenShot(indexPath) { image in
            DispatchQueue.main.async {
                self.previewImage.image = image
            }
        }
    }
}

extension PreviewCollectionViewCell {
    
    func layout() {
        previewImage.isUserInteractionEnabled = false
        
        [
            previewImage
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: self.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            previewImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
